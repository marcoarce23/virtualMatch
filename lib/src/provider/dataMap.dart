import 'dart:convert';
import 'package:http/http.dart' as http;


Map dataMap(http.Response response) {
  Map dataMap;

  if (response.statusCode == 200)
    dataMap = json.decode(response.body);
  else
    dataMap.addAll(throw Exception('Error: Status 400'));

  return dataMap;
}

