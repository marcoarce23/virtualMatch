import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/api/IApiUpload.dart';
import 'package:mime_type/mime_type.dart';

class ApiUpload {
  String _secureUrl = 'secure_url';

  dynamic respData(http.Response resp) {
    if (resp.statusCode != STATUSCODE200 && resp.statusCode != STATUSCODE201) {
  
      return null;
    }

    final respData = json.decode(resp.body);
  
    return respData[_secureUrl];
  }

  Future<String> uploadFile(File imagen) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

  
    return respData(resp);
  }

  Future<String> uploadImage(String image) async {
    final url = Uri.parse(ApiCloudy().api());
    final mimeType = mime(image).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

  
    return respData(resp);
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
  }
}
