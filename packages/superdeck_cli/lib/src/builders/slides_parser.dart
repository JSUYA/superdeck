import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class SlidesParser {
  // Constructor that accepts the text input for parsing.
  SlidesParser(this.text);
  final String text;

  final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

  // Public method that parses the text and returns a list of SlideData.
  List<Map<String, dynamic>> parse() {
    // Map the front matter and content to a list of _SlideParserData objects.
    return _extractSlides(text).map((slide) {
      final frontMatter = _extractFrontMatter(slide);
      final options = _parseFrontMatter(frontMatter);
      final content = _removeMatchingFrontMatter(slide, frontMatter);
      return {
        ...options,
        'content': content,
      }.cast<String, dynamic>();
    }).toList();
  }

    String _extractFrontMatter(String slide) {
    return _frontMatterRegex.firstMatch(slide)?.group(1) ?? '';
  }

  Map<dynamic, dynamic> _parseFrontMatter(String frontMatter) {
    return loadYaml(frontMatter) as YamlMap? ?? {};
  }

  String _removeMatchingFrontMatter(String slide, String frontMatter) {
    return slide
          .substring(_frontMatterRegex.matchAsPrefix(slide)?.end ?? 0)
          .trim();
  }

  List<String> _extractSlides(String content) {
    final lines = content.split('\n');
    final slides = <String>[];
    final buffer = StringBuffer();
    bool inSlide = false;

    for (var line in lines) {
      if (line.trim() == '---') {
        if (buffer.isNotEmpty) {
          if (inSlide) {
            // Add the slide content to the list of slides
            slides.add(buffer.toString().trim());
            inSlide = false;
            buffer.clear();
          } else {
            inSlide = true;
          }
        }
        buffer.writeln(line);
      } else {
        buffer.writeln(line);
      }
    }

    // Capture any remaining content as a slide
    if (buffer.isNotEmpty) {
      slides.add(buffer.toString().trim());
    }

    return slides;
  }
}

String replaceMermaidContent(String content) {
  final RegExp mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');
  final List<Map<String, dynamic>> replacements = [];

  final Iterable<Match> matches = mermaidBlockRegex.allMatches(content);
  for (final Match match in matches) {
    final String? mermaidSyntax = match.group(1);
    if (mermaidSyntax == null) continue;

    // Process the mermaid syntax to generate an image file
    final imageFile = _processMermaidSyntax(mermaidSyntax);

    final relativePath =
        relative(imageFile.path, from: config.assetsDir.parent.path);

    final String imageMarkdown = '![Mermaid Diagram]($relativePath)';

    print(replacements);

    // Collect replacement information
    replacements.add({
      'start': match.start,
      'end': match.end,
      'replacement': imageMarkdown,
    });
  }

  // Apply replacements in reverse order
  for (var replacement in replacements.reversed) {
    final int start = replacement['start'];
    final int end = replacement['end'];
    final String replacementText = replacement['replacement'];

    content =
        content.substring(0, start) + replacementText + content.substring(end);
  }

  return content;
}

File _processMermaidSyntax(String mermaidSyntax) {
  String tempFilePath = 'temp.mmd';
  final tempFile = File(tempFilePath);

  try {
    mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

    // has the mermaidSyntax string
    final fileHash = mermaidSyntax.hashCode;

    tempFile.writeAsString(mermaidSyntax);

    final outputFile = File(join(config.assetsImageDir.path, '$fileHash.png'));

    if (!outputFile.parent.existsSync()) {
      outputFile.parent.createSync(recursive: true);
    }

    final imageSizeParams = '--scale 2'.split(' ');
    final params =
        '-t dark -b transparent -i $tempFilePath -o ${outputFile.path} '
            .split(' ');

    final result = Process.runSync('mmdc', [...params, ...imageSizeParams]);

    if (result.exitCode != 0) {
      print('Error while processing mermaid syntax');
      print(result.stderr);
    }

    return outputFile;
  } catch (e) {
    throw Exception('Error while processing mermaid syntax');
  } finally {
    if (tempFile.existsSync()) {
      tempFile.deleteSync();
    }
  }
}

final config = SuperDeckConfig();

class SuperDeckConfig {
  SuperDeckConfig();

  String get _assetsDirName => 'assets';

  String get _slidesMarkdownName => 'slides.md';

  File get slidesMarkdownFile => File(_slidesMarkdownName);
  Directory get assetsDir => Directory(_assetsDirName);
  Directory get assetsImageDir => Directory(join(_assetsDirName, 'images'));
  File get slidesJsonFile => File(join(_assetsDirName, 'slides.json'));
  File get assetsJsonFile => File(join(_assetsDirName, 'assets.json'));
}

void loadSlideMarkdown() {
  final slidesMarkdown = config.slidesMarkdownFile;

  if (!slidesMarkdown.existsSync()) {
    throw Exception('Slides markdown file not found');
  }

  // Clean up assets folder
  config.assetsImageDir.listSync().forEach((element) {
    if (element is File) {
      element.deleteSync(recursive: true);
    }
  });

  final presentationContent = slidesMarkdown.readAsStringSync();

  final replacedContent = replaceMermaidContent(presentationContent);

  final slides = SlidesParser(replacedContent).parse();

  _saveSlideJson(slides);
}

void _saveSlideJson(List<Map<String, dynamic>> contents) {
  final slidesJson = config.slidesJsonFile;
  final assetsJson = config.assetsJsonFile;

  if (!slidesJson.existsSync()) {
    slidesJson.createSync(recursive: true);
  }

  if (!assetsJson.existsSync()) {
    assetsJson.createSync(recursive: true);
  }
  // Write a json file with a list of slides
  slidesJson.writeAsStringSync(prettyJson(contents));
  // Map<String,String> assets = {};
  // The key will be the file name and the value will be a base64 encoded string
  final files = config.assetsImageDir.listSync();
  var assetMap = {};

  for (var file in files) {
    if (file is File) {
      final bytes = file.readAsBytesSync();
      final base64 = base64Encode(bytes);
      // assets[file.path] = base64;
      final relativePath =
          relative(file.path, from: config.assetsDir.parent.path);

      assetMap[relativePath] = base64;
    }
  }
  //  conver a map to a an array of objects with key and value
  final listOfAssets =
      assetMap.entries.map((e) => {'name': e.key, 'base64': e.value}).toList();
  assetsJson.writeAsStringSync(prettyJson(listOfAssets));
}

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
