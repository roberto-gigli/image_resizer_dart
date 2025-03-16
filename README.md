# Image Resizer Dart

A Dart command-line application for resizing images. This project provides a library for resizing images and a command-line tool to use the library.

## Features

- Supports multiple image formats (e.g., PNG, JPEG, GIF, BMP, etc.)
- Maintains aspect ratio if desired
- Command-line interface for easy usage

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/image_resizer_dart.git
   ```
2. Navigate to the project directory:
   ```sh
   cd image_resizer_dart
   ```
3. Get the dependencies:
   ```sh
   dart pub get
   ```

## Build

To build the executable, run the following command:

```sh
dart compile exe bin/main.dart -o bin/image_resizer
```

This command will create an executable named `image_resizer` in the `bin` directory.

## Usage

To use the command-line tool, run the following command:

```sh
bin/image_resizer --imagePath <path_to_image> --width <width> --height <height> [--maintainAspect <true|false>]
```

### Example

```sh
bin/image_resizer --imagePath example.png --width 100 --height 100 --maintainAspect true
```

This will resize the `example.png` image to 100x100 pixels while maintaining the aspect ratio.

## Library

You can also use the library in your Dart project:

```dart
import 'dart:typed_data';
import 'package:image_resizer_dart/image_resizer_dart.dart';

void main() {
  Uint8List bytes = // ... load your image bytes
  ImageFormat format = ImageFormat.png; // specify the format
  bool maintainAspect = true;
  int width = 100;
  int height = 100;

  var result = resizeImage(bytes, format, maintainAspect, width, height);

  // Use the resized image data
  Uint8List resizedImageData = result.data;
}
```

## License

This project is licensed under the MIT License.
