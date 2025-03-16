import 'dart:io';

import 'package:args/args.dart';
import 'package:image_resizer_dart/image_resizer_dart.dart'
    as image_resizer_lib;

final argParser = ArgParser()
  ..addOption(
    "imagePath",
    mandatory: true,
  )
  ..addOption("width", mandatory: true)
  ..addOption("height", mandatory: true)
  ..addOption("maintainAspect", defaultsTo: "true", allowed: ["true", "false"]);

void main(List<String> arguments) {
  final parsedArgs = argParser.parse(arguments);

  final imagePath = parsedArgs.option("imagePath");
  if (imagePath == null) throw Exception("Must provide imagePath");

  final width = int.tryParse(parsedArgs.option("width") ?? "");
  if (width == null) throw Exception("width must be a number");

  final height = int.tryParse(parsedArgs.option("height") ?? "");
  if (height == null) throw Exception("height must be a number");

  final maintainAspect = switch (parsedArgs.option("maintainAspect")) {
    "true" => true,
    "false" => false,
    _ => throw Exception("maintainAspect must be true or false")
  };

  final bytes = File(imagePath).readAsBytesSync();

  final format = image_resizer_lib.imageFormatByExtension(imagePath);

  final stopwatch = Stopwatch()..start();

  final result = image_resizer_lib.resizeImage(
    bytes,
    format,
    maintainAspect,
    width,
    height,
  );

  stopwatch.stop();

  print("Time taker: ${stopwatch.elapsed}");

  final extension = result.format.extensions.firstOrNull;
  if (extension == null) throw Exception("Could not determine image extension");

  final outputPath = "resized_image.$extension";

  File(outputPath).writeAsBytesSync(result.data);
  print("Image saved to $outputPath");
}
