import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';

Map dataMap(http.Response response) {
  Map dataMap;
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == STATUSCODE200)
    dataMap = json.decode(response.body);
  else
    throw Exception(
        'Error occured while Communication with Server with StatusCode : ${response.statusCode}');

  return dataMap;
}

List<IEntityJson> getListIEntityJson(http.Response response, IEntityJson entity,
    Map<String, dynamic> decodeData, List<IEntityJson> list) {
  // final List<IEntityJson> list = new List();

  if (response.statusCode == 200) {
    Map dataMap = json.decode(response.body);
    List<dynamic> listDynamic = dataMap[PRIMARY_KEY];
    //      //print(listDynamic);
    for (int i = 0; i < listDynamic.length; i++) {
      decodeData = listDynamic[i];
      list.add(entity.fromJson(decodeData));
    }
  } else {
    Exception('Error: Status 400');
  }

  return list;
}
