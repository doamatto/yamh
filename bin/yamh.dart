import 'dart:io';

import 'package:args/args.dart';
import 'package:markdown/markdown.dart';

void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('file',
      abbr: 'f',
      help: 'Use this option to parse a Markdown file to HTML.',
      valueHelp: 'file');
  parser.addOption('string',
      abbr: 's',
      help:
          'Use this option to parse a string to HTML. It can be converted to either an HTML file or returned in the console.',
      valueHelp: 'string');
  parser.addOption('out',
      abbr: 'o',
      help:
          'Provide the directory or file you want converted HTML files to go.',
      valueHelp: 'out-dir');
  parser.addFlag('help',
      abbr: 'h', help: 'Use this flag to get help with YAMH');

  var args = parser.parse(arguments);
  if (args['help'] == true) {
    return printUsage(parser);
  }
  if (args['file'] == null && args['string'] == null) {
    throw ArgumentError(
        '[YAMH] Error: need to use at least one option (file or string)');
  } // Make sure an option is used
  if (args['file'] != null && args['string'] != null) {
    throw ArgumentError(
        '[YAMH] Error: cannot define both file and string arguments.');
  } // Make sure only one option is used
  if (args['out'] != null && args['out'] == '') {
    throw ArgumentError(
        '[YAMH] Error: The output file must be defined to use the -o/--out flag');
  } // Make sure that if the output directory is used that it isn't empty

  if (args['file'] != null) {
    if (args['file'] == '') {
      throw ArgumentError(
          '[YAMH] Error: File value is empty. Make sure to mention where the file is'); // Make sure that string isn't empty
    }
    if (args['file'].endsWith('.md') == false) {
      throw FileSystemException(
          "[YAMH] The file you provided may not be a Markdown file, as it doesn't end in .md. Please change the file extension and try again.",
          args['file']);
    } // Check if file ends in .MD; could just ignore this though.
    if (await File(args['file']).exists() == false) {
      throw FileSystemException(
          '[YAMH] The file you provided seems to not exist. Check if the file does exist and that you spelt the file and its path properly.',
          args['file']);
    }

    var input = File(args['file']);
    await input.readAsString().then((String file) {
      var parsed = markdownToHtml(file, inlineSyntaxes: [InlineHtmlSyntax()]);
      if (args['out'] != null) {
        SaveFile(parsed, args['out']);
      } else {
        var inPath = input.path;
        inPath = inPath.replaceAll(RegExp(r'\.md'), ''); // Remove .md from file
        File(inPath + '.html').writeAsString(parsed);
      } // Write HTML to same place as Markdown file, or a specific place
    }); // Read file into String
  }

  if (args['string'] != null) {
    if (args['string'] == '') {
      throw ArgumentError(
          "[YAMH] You didn't provide a string to be parsed. Friendly reminder that spaces and « ' » will need double-quotes surrounding your string.");
    }
    var parsed =
        markdownToHtml(args['string'], inlineSyntaxes: [InlineHtmlSyntax()]);
    if (args['out'] != null) {
      SaveFile(parsed, args['out']);
    } else {
      print(parsed);
      return;
    } // Write HTML to console or to place specified
  }
}

void printUsage(ArgParser parser) {
  print('');
  print('YAMH: Yet Another Markdown to HTML converter');
  print('Developed by Matt Ronchetto (doamatto) - doamatto.xyz');
  print('Licensed under the MIT License.');
  print('Source: https://github.com/doamatto/yamh');
  print('');
  print('=== === ===');
  print('');
  print(parser.usage);
} // Print usage for when using in the command line

void SaveFile(String input, String output) async {
  var outpath = output.replaceAll(RegExp(r'\.html'), '');
  await File(outpath + '.html').writeAsString(input);
  return;
}
