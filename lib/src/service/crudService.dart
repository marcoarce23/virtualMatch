import 'package:flutter/material.dart';
import 'package:virtual_match/src/api/DataMap.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MultimediaService with ChangeNotifier {
  bool isLoading = true;

  Future<Map<String, dynamic>> repository(IEntityMap entity, String url) async {
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

  Future<List<IEntityJson>> get(IEntityJson entityJson, String url) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = url;
    final response = await http.get(_apiRest);
    print(_apiRest);

    isLoading = false;
    notifyListeners();
    // return _result;
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

  _insert(IEntityMap entity, String url) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = url; // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('urlDDDDDDD: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  _update(IEntityMap entity, String url) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = url; // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('urlDDDDDDD: $apiRest');
    final response = await http.put(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
}
