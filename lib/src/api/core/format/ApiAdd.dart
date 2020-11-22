import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/format/ApiResource.dart';
import 'package:virtual_match/src/api/dataMap.dart';

class ApiAdd {
  Future<Map<String, dynamic>> add(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest =
        api['add'][0].toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('urlDDDDDDD: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> add1(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest =
        api['add1'][0].toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('urlDDDDDDD: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> update(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest = api['update'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO

    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //FIN DE LA CLASE
