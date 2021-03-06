import 'package:flutter/material.dart';
import 'package:virtual_match/src/api/DataMap.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/util/StatusCode.dart';

class CrudService with ChangeNotifier {
  bool isLoading = true;

  Future<dynamic> repository(IEntityMap entity, String url) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    isLoading = true;
    switch (entity.states) {
      case StateEntity.Insert:
        result = _insert(entity, url);
        break;
      case StateEntity.Update:
        result = _update(entity, url);
        break;
      default:
    }

    print('DEL VALOR DE EVENT BLOC: $result');
    isLoading = false;
    notifyListeners();

    print('RRRRR: $result');
    return result;
  }

  Future<Map<String, dynamic>> delete(
      String id, String usuario, String url) async {
    final apiRest = url +
        '/' +
        id +
        '/usuario/' +
        usuario; // eventResourceAdd['add'][0].toString()   ;
    print('url: $apiRest');
    final response = await http
        .delete(apiRest, headers: {"Content-Type": "application/json"});

    isLoading = false;
    notifyListeners();
    return dataMap(response);
  }

  Future<Map<String, dynamic>> execute(String url) async {
    final apiRest = url; // eventResourceAdd['add'][0].toString()   ;
    print('urlvvvvvv: $apiRest');
    final response = await http.post(apiRest);

    isLoading = false;
    notifyListeners();
    return dataMap(response);
  }

  Future<List<IEntityJson>> get(IEntityJson entityJson, String url) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;
    print('URLLLL URLLL: $url');
    final _apiRest = url;
    final response = await http.get(_apiRest);
    print(_apiRest);

    isLoading = false;
    notifyListeners();
    // return _result;
    print(getListIEntityJson(response, entityJson, decodeData, list));
    return getListIEntityJson(response, entityJson, decodeData, list);
  }

  Future<List<IEntityJson>> getId(
      IEntityJson entityJson, int value, String url) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = url + '/' + value.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    isLoading = false;
    notifyListeners();
    // return _result;

    return getListIEntityJson(response, entityJson, decodeData, list);
  }

  Future<Map<String, dynamic>> _insert(IEntityMap entity, String url) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = url; // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('urlDDDDDDD: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);

    var dataMap;

    if (response.statusCode == STATUSCODE200 ||
        response.statusCode == STATUSCODE400)
      dataMap = json.decode(response.body);
    else
      dataMap.addAll(throw Exception(STATUSCODE500));

    return dataMap;
  }

  _update(IEntityMap entity, String url) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = url; // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('urlDDDDDDD: $apiRest');
    final response = await http.put(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);

    var dataMap;

    if (response.statusCode == STATUSCODE200)
      dataMap = json.decode(response.body);
    else
      dataMap.addAll(throw Exception(STATUSCODE400));
    return dataMap;
  }
}
