import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/api/Resultado/ApiResource.dart';

import 'package:virtual_match/src/model/entity/IEntity.dart';

import 'package:virtual_match/src/api/dataMap.dart';

class ApiUpdate {
  Future<Map<String, dynamic>> update(IEntityMap entity, int id) async {
    String _body = json.encode(entity.toJson());

    final apiRest = api['update'][0].toString() +
        '/' +
        id.toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO

    final response = await http.put(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> updateLiga(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest = api['updateLiga'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO

    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> updateFaseGrupo(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest = api['updateFaseGrupo'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO

    print(_body);
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> updateEliminatoriaGrupo(
      IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest = api['updateEliminatoriaGrupo'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO

    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //F
