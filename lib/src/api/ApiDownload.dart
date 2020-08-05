import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:virtual_match/src/api/IApiUpload.dart';

class ApiDownload {
  Future<String> uploadImage(File imagen) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    return respData(resp);
    // if (resp.statusCode != 200 && resp.statusCode != 201) {
    //   print('Algo salio mal IMAGENNNN ${resp.body}');
    //   return null;
    // }

    // final respData = json.decode(resp.body);
    // print(respData);
    // return respData['secure_url'];
  }

  Future<String> uploadImagenFile(String imagen) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(imagen).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    return respData(resp);
    // if (resp.statusCode != 200 && resp.statusCode != 201) {
    //   print('Algo salio mal PDF ${resp.body}');
    //   return null;
    // }

    // final respData = json.decode(resp.body);
    // print(respData);
    // return respData['secure_url'];
  }

  Future<String> uploadVideo(String imagen) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(imagen).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    return respData(resp);

    // if (resp.statusCode != 200 && resp.statusCode != 201) {
    //   print('Algo salio mal videooo ${resp.body}');
    //   return null;
    // }

    // final respData = json.decode(resp.body);
    // print(respData);
    // return respData['secure_url'];
  }

  dynamic respData(http.Response resp) {
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal videooo ${resp.body}');
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
