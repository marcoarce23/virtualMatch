import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/clasification/ApiResource.dart';

class ApiGet {
  Future<List<IEntityJson>> get(IEntityJson entity, int value) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['get'][0].toString() + '/' + value.toString();
    final _primaryKey = api['get'][1].toString();
    final response = await http.get(_apiRest);

    print(_apiRest);
    print(_primaryKey);

    if (response.statusCode == 200) {
      Map dataMap = json.decode(response.body);
      List<dynamic> listDynamic = dataMap[_primaryKey];
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
}
