import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/util/StatusCode.dart';

Map dataMap(http.Response response) {
  Map dataMap;

  if (response.statusCode == STATUSCODE200)
    dataMap = json.decode(response.body);
  else
    dataMap.addAll(throw Exception(STATUSCODE400));

  print('DATA MAP: $dataMap');
  return dataMap;
}
