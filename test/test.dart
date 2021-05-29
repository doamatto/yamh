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
    await yamh_file(file, null);
    var newFile = File('test/test.html');
    expect(await newFile.exists(), true);
    var newFileStr = newFile.readAsString().toString();
    expect(
        newFileStr, equals(File('test/expect.html').readAsString().toString()));
  });

  test('File converts properly to custom directory', () async {
    var file = File('test/test.md');
    await yamh_file(file, 'test/testing/test.html');
    var newFile = File('test/testing/test.html');
    expect(await newFile.exists(), true);
    var newFileStr = newFile.readAsString().toString();
    expect(
        newFileStr, equals(File('test/expect.html').readAsString().toString()));
  });
}
