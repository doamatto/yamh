import 'dart:io';
import 'package:yamh/yamh.dart';

void main() async {
  await yamh_str('**This** is a *markdown* string.', null).then((String str) {
    print(str); // <p><strong>This</strong> is a <em>markdown</em> string.</p>
  });

  final file = File('../test/test.md');
  await yamh_file(file, null);
}
