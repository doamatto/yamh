# Yet Another Markdown to HTML converter
A dirt simple, null-safe Markdown to HTML converter.

## Features
- Functions for both Dart and Flutter
- Support for either string input or file input
- Batch parse Markdown files\*
- Available for NPM\*\*
- Written in Dart (because I felt like it)

> \* Planned features; not complete or in the latest build yet.
>
> \*\* This would actually be really nice to make things compile way faster with several files. Planned, but not guaranteed.

## Usage
You can either [build](#Building) YAMH or [download a pre-built binary](https://github.com/doamatto/yamh/releases) from GitHub.

### Command-line usage
You can see the usage information provided by running `./yamh -h` or `./yamh --help`. All of these commands are flags/options for the `./yamh` command and should be appended to it.

- `-f, --file <file>`&mdash; Parse a Markdown file to HTML, where `<file>` is the path to a Markdown file.
- `-s, --string <string>`&mdash; Parse a string containing Markdown to HTML, where `<string>` is the aforementioned string.
- `-o, --out <out-dir>`&mdash; Specify a place for converted HTML files to go.
    - **If you are using the `-s` option**, it will default to saving in the console.
    - **If you are using the `-f` option**, it will default to saving in the same directory as the Markdown file. 

### in Dart and Flutter
There are two core functions you can use:
- `yamh_str(<string>, [output])`&mdash; Converts a string of Markdown to HTML. You can omit the `[output]` with `null`, and have it be returned for using in a promise (see the example in `example/example.dart`).
- `yamh_file(<file>, [output])`&mdash; Converts a Markdown file to a HTML file. You can omit the `[output]` with `null`, and have the file be saved to the same directory as the Markdown file. Otherwise, you can specify where you want the file to be saved.

You can see a working example in both `example/example.dart`, as well as `test/test.dart`. You can read the full API reference [here](https://pub.dev/documentation/yamh/latest/) or generate it locally using [`dartdoc`](https://pub.dev/packages/dartdoc).

### in Node/NPM
This has not been implemented yet. When it is, this will be updated to show the relevant documentation. It may also never happen, due to a lack of knowledge.

## Building
1. Install [Dart](https://dart.dev)
2. Fetch dependencies (`dart pub get`)

### Building for the command-line
To build binaries, use `dart2native bin/yamh.dart -o build/yamh.ext`; replacing `?? ext ??` with `?? exe ??` if on Windows or `?? app ??` if on macOS.

### Building for JavaScript/Web
To build, use `dart2js bin/yamh.dart -o build/yamh.js -m -O2`. You can replace ?? build/yamh.js ?? for wherever you want the JavaScript file to be saved to.

## Acknowledgements
This project is licensed under the MIT License. You can see a copy of it in the `LICENSE` file in the root of this repository.

Special thanks to:
- the Dart and Flutter teams for having great documenation of the language,
- [emn178](https://github.com/emn178) for making a [Markdown](https://github.com/emn178/markdown) example that is used in test and examples; and:
- all of the dependencies of YAMH for helping power this tool.

This was made to try and cross off the ?? Markdown to HTML converter ?? [here](https://cyckl.net/idea). Although it does function for other things, you can have a single binary to interact with for all your needs.
