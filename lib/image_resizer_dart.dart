import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:path/path.dart';

({Uint8List data, ImageFormat format}) resizeImage(
  Uint8List bytes,
  ImageFormat? format,
  bool maintainAspect,
  int? width,
  int? height,
) {
  final decoder = format?.decoder;

  if (decoder == null) {
    throw UnsupportedError("Unsupported image format");
  }

  final image = decoder.decode(bytes);

  if (image == null) {
    throw UnsupportedError(
        "Could not decode image with the given image format");
  }

  final resizedImage = copyResize(
    image,
    width: width,
    height: height,
    maintainAspect: maintainAspect,
  );

  final encodingFormat =
      switch (format?.encoder) { null => ImageFormat.png, _ => format! };

  final encoder = encodingFormat.encoder!;

  final resizedImageData = encoder.encode(resizedImage);

  return (data: resizedImageData, format: encodingFormat);
}

ImageFormat imageFormatByExtension(String path) {
  final ext = extension(path).replaceFirst(".", "");

  return ImageFormat.values.firstWhere(
    (element) => element.extensions.contains(ext),
  );
}

extension ImageFormatExt on ImageFormat {
  List<String> get extensions {
    return switch (this) {
      ImageFormat.bmp => ["bmp"],
      ImageFormat.cur => ["cur"],
      ImageFormat.exr => ["exr"],
      ImageFormat.gif => ["gif"],
      ImageFormat.ico => ["ico"],
      ImageFormat.jpg => ["jpg", "jpeg"],
      ImageFormat.png => ["png"],
      ImageFormat.pnm => ["pbm", "pam", "ppm", "pgm"],
      ImageFormat.psd => ["psd"],
      ImageFormat.pvr => ["pvr"],
      ImageFormat.tga => ["tga"],
      ImageFormat.tiff => ["tiff", "tif"],
      ImageFormat.webp => ["webp"],
      ImageFormat.custom => [],
      ImageFormat.invalid => [],
    };
  }

  Decoder? get decoder => switch (this) {
        ImageFormat.bmp => BmpDecoder(),
        ImageFormat.exr => ExrDecoder(),
        ImageFormat.gif => GifDecoder(),
        ImageFormat.ico => IcoDecoder(),
        ImageFormat.jpg => JpegDecoder(),
        ImageFormat.png => PngDecoder(),
        ImageFormat.pnm => PnmDecoder(),
        ImageFormat.psd => PsdDecoder(),
        ImageFormat.pvr => PvrDecoder(),
        ImageFormat.tga => TgaDecoder(),
        ImageFormat.tiff => TiffDecoder(),
        ImageFormat.webp => WebPDecoder(),
        _ => null,
      };

  Encoder? get encoder => switch (this) {
        ImageFormat.bmp => BmpEncoder(),
        ImageFormat.gif => GifEncoder(),
        ImageFormat.jpg => JpegEncoder(),
        ImageFormat.png => PngEncoder(),
        ImageFormat.pvr => PvrEncoder(),
        ImageFormat.tga => TgaEncoder(),
        ImageFormat.tiff => TiffEncoder(),
        _ => null,
      };
}
