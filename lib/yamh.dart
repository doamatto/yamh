import 'dart:io';

import 'package:markdown/markdown.dart';

/// Converts a Markdown file to a HTML file.
///
/// Throws an [ArgumentError] if either the input or output is mentioned, but left empty. Throws a [FileSystemException] is the file doesn't end in « .md » or if the file doesn't exist. If no output is defined, the HTML is saved to the same directory as the input file. A successful save returns a string saying « SAVED » is returned.
void yamh_file(File infile, String? output) async {
  var fileStr = infile.toString();
  if (fileStr == '') {
    throw ArgumentError(
        '[YAMH] You specified an input, however left the value blank.');
  }
  if (fileStr.endsWith('.md') == false) {
    throw FileSystemException(
        "[YAMH] The file you provided may not be a Markdown file, as it doesn't end in .md. Please change the file extension and try again.",
        fileStr);
  }
  if (await infile.exists() == false) {
    throw FileSystemException(
        '[YAMH] The file you provided seems to not exist. Check if the file does exist and that you spelt the file and its path properly.',
        fileStr);
  }

  await infile.readAsString().then((String data) {
    var parsed = markdownToHtml(data, inlineSyntaxes: [InlineHtmlSyntax()]);
    if (output != null) {
      _saveFile(parsed, output); // Write HTML to defined location
      return 'SAVED';
    } else {
      var inPath = infile.path;
      inPath =
          inPath.replaceAll(RegExp(r'\.md'), ''); // Remove .md from file path
      File(inPath + '.html')
          .writeAsString(parsed); // Write HTML to same place as Markdown file
      return 'SAVED';
    }
  }); // Read file into string
}

/// Converts a string with Markdown to either a string of HTML or a HTML file.
///
/// Throws an [ArgumentError] if either the input or output is mentioned, but left empty. If no output is defined, the HTML is returned as a String. If an output is defined and is successfully saved to, a string saying « SAVED » is returned.
Future<String> yamh_str(String input, String? output) async {
  if (input == '') {
    throw ArgumentError(
        '[YAMH] You specified an input, however left the value blank.');
  }
  var parsed = markdownToHtml(input, inlineSyntaxes: [InlineHtmlSyntax()]);
  if (output != null) {
    await _saveFile(parsed, output);
    return 'SAVED'; // Need to return something; so we used 'SAVED' to also allow simple callbacks with strings
  } else {
    return parsed;
  }
}

/// Saves the parsed Markdown string to the file specified
///
/// Throws an [ArgumentError] if the output is mentioned, but left empty.
Future<void> _saveFile(String content, String output) async {
  if (output == '') {
    throw ArgumentError(
        '[YAMH] You specified an output, however left the value blank.');
  }
  var outpath = output.replaceAll(RegExp(r'\.html'), '');
  await File(outpath + '.html').writeAsString(content, mode: FileMode.write);
  return;
}
