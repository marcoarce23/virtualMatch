import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:virtual_match/src/model/entity/IEntity.dart';

import 'package:virtual_match/src/api/dataMap.dart';
import 'package:virtual_match/src/api/notification/ApiResource.dart';

class ApiUpdate {
  Future<Map<String, dynamic>> update(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = api['update'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('url: $apiRest');
    final response = await http.put(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //F
