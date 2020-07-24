import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/services.dart';

sharedImage(String imagePath, String nameImage, String nameAttachExtension,
    String extensionImage, String detail) async {
  final ByteData bytes = await rootBundle.load(imagePath);
  Share.file(nameImage, nameAttachExtension, bytes.buffer.asUint8List(),
      'image/$extensionImage',
      text: detail);
}

sharedText(String title, String text, String mimeType) async {
  Share.text(title, text, mimeType);
}