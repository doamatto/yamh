import 'dart:io';

import 'package:args/args.dart';
import 'package:markdown/markdown.dart';

void main(List<String> arguments) {
  var parser = ArgParser();
  parser.addOption('file', abbr: 'f');
  parser.addOption('string', abbr: 's');
  parser.addOption('out', abbr: 'o');

  var args = parser.parse(arguments);
  if (args['file'] == null && args['string'] == null) {
    throw NullThrownError();
  } // Make sure an option is used
  if (args['file'] != null && args['string'] != null) {
    throw ArgumentError(
        '[YAMH] Error: cannot define both file and string arguments.');
  } // Make sure only one option is used
  if (args['out'] != null && args['out'].isEmpty()) {
    throw NullThrownError();
  } // Make sure that if the output directory is used that it isn't empty

  if (args['file'] != null) {
    if (args['file'].isEmpty()) {
      throw NullThrownError(); // Make sure that string isn't empty
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
    if (args['string'].isEmpty()) {
      throw NullThrownError();
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
