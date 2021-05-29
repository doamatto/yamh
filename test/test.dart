import 'dart:io';
import 'package:yamh/yamh.dart';
import 'package:test/test.dart';

void main() {
  test('String converts properly', () {
    var string = '**This** is a *markdown* string.';
    yamh_str(string, null).then((str) {
      expect(
          str,
          equals(
              '<p><strong>This</strong> is a <em>markdown</em> string.</p>\n'));
    });
  });

  test('File converts properly to same directory', () async {
    var file = File('test/test.md');
    yamh_file(file, null);
    var newFile = File('test.html');
    expect(await newFile.exists(), true);
    var newFileStr = newFile.readAsString();
    expect(
        newFileStr,
        equals(
            '<p><strong>This</strong> is a <em>markdown</em> string.</p>\n'));
  });

  test('File converts properly to custom directory', () async {
    var file = File('test.md');
    yamh_file(file, 'testing/test.html');
    var newFile = File('testing/test.html');
    expect(await newFile.exists(), true);
    var newFileStr = newFile.readAsString();
    expect(
        newFileStr,
        equals(
            '<p><strong>This</strong> is a <em>markdown</em> string.</p>\n'));
  });
}
