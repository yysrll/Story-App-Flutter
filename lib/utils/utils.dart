import 'dart:typed_data';

import 'package:image/image.dart' as img;

class Utils {
  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes as Uint8List)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(image, quality: compressQuality);
      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}