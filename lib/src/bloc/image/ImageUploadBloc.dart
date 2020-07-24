import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:virtual_match/src/service/apiUpload.dart';
import 'package:mime_type/mime_type.dart';

class ImageBloc {
  // Stream<List<EventModel>> get eventStream => _controller.stream;
  // Stream<bool> get loading => _loadingController.stream;

  Future<String> uploadImageFile(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/propia/image/upload?upload_preset=luwzr1vw');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal IMAGENNNN ${resp.body}');
      return 'Algo salio mal PDF ${resp.body}';
    }
  }

  Future<String> uploadImage(String imagen) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(imagen).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal PDF ${resp.body}');
      return 'Algo salio mal PDF ${resp.body}';
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }

  Future<String> uploadVideo(String imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/propia/video/upload?upload_preset=luwzr1vw');
    final mimeType = mime(imagen).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal videooo ${resp.body}');
      return 'Algo salio mal PDF ${resp.body}';
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
