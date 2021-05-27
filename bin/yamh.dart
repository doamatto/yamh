import 'dart:io';

import 'package:args/args.dart';
import 'package:markdown/markdown.dart';

void main(List<String> arguments) {
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
      throw ArgumentError(
          "[YAMH] Error: Markdown file doesn't end in « .md ». Make sure your file ends in that extension.");
    } // Check if file ends in .MD; could just ignore this though.

    var file = args['file'].readAsString();
    var parsed = markdownToHtml(file, inlineSyntaxes: [InlineHtmlSyntax()]);

    if (args['out'] != null) {
      if (args['out'].endsWith('.html') ==
          false | (args['out'].endsWith('.htm') == false)) {
        File(args['out'] + '.html').writeAsString(parsed);
      } // Check if the output ends in .htm(l)
      File(args['out']).writeAsString(parsed);
    } else {
      File(args['file'].directoryPath + args['file'].name + '.html')
          .writeAsString(parsed);
    } // Write HTML to same place as Markdown file, or a specific place
  } // Parse a Markdown file

  if (args['string'] != null) {
    if (args['string'] == '') {
      throw ArgumentError(
          "[YAMH] You didn't provide a string to be parsed. Friendly reminder that spaces and « ' » will need double-quotes surrounding your string.");
    }
    var parsed =
        markdownToHtml(args['string'], inlineSyntaxes: [InlineHtmlSyntax()]);
    if (args['out'] != null) {
      if (args['out'].endsWith('.html') ==
          false | (args['out'].endsWith('.htm') == false)) {
        File(args['out'] + '.html').writeAsString(parsed);
      } // Check if the output ends in .htm(l)
      File(args['out']).writeAsString(parsed);
    } else {
      print(parsed);
      return;
    } // Write HTML to console or to place specified
  }
}

void printUsage(ArgParser parser) {
  print(parser.usage);
}
