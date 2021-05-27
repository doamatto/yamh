# Yet Another Markdown to HTML converter
A dirt simple, null-safe Markdown to HTML converter.

## Features
- Functions for both Dart and Flutter\*
- FFI compatiblity compilation\*
- Support for either string input or file input
- Batch parse Markdown files\*
- Available for NPM\*\*
- Powers a WTFF\*\*\*
- Written in Dart (because I felt like it)

\* Planned features; not complete or in the latest build yet.
\*\* This would actually be really nice to make things compile way faster with several files. Planned, but not guaranteed.
\*\*\* This is just an idea of mine that I may or may not do. Stands for `Way Too Fast Framework` and would be used for websites.

## Usage
### Command-line usage
There are two ways you can use YAMH:
- `./yamh -f/--file <mdfile>`, where `<mdfile>` is the path to your Markdown file and you choose between `-f` or `--file` as a flag; and:
- `./yamh -s/--str <string>`, where `<string>` is a string that contains the Markdown you want to convert and you choose between `-s` or `--str` as a flag.

### in Dart

### in Flutter
This has not been implemented yet. When it is, this will be updated to show the relevant documentation.

## Building
1. Install [Dart](https://dart.dev)
2. Fetch dependencies (`dart pub get`)
3. Build the binaries (`dart2native bin/yamh.dart -o build/yamh.ext`; replacing `« ext »` with `« exe »` if on Windows or `« app »` if on macOS)

## Acknowledgements
This project is licensed under the MIT License. You can see a copy of it in the `LICENSE` file in the root of this repository.

Special thanks to:
- the Dart team for having great documenation of the language,
- the Flutter team for having amazing documentation of the utility; and:
- all of the dependencies of YAMH for helping power this tool.
