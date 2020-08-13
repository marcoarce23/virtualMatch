import 'package:flutter/material.dart';
import 'package:virtual_match/src/api/event/ApiGet.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/event/ApiAdd.dart';
import 'package:virtual_match/src/api/event/ApiUpdate.dart';
import 'package:virtual_match/src/api/event/ApiDelete.dart';

class EventService with ChangeNotifier {
  bool isLoading = true;

  final _apiAdd = new ApiAdd();
  final _apiDelete = new ApiDelete();
  final _apiUpdate = new ApiUpdate();
  final _apiGet = new ApiGet();

  Future<Map<String, dynamic>> repository(IEntityMap entity) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    isLoading = true;
    switch (entity.states) {
      case StateEntity.Insert:
        result = await _apiAdd.add(entity);
        break;
      case StateEntity.Update:
        result = await _apiUpdate.update(entity);
        break;
      default:
    }

    print('DEL VALOR DE EVENT BLOC: $result');
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> delete(String id, String usuario) async {
    var result;
    isLoading = true;
    result = await _apiDelete.delete(id, usuario);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<List<IEntityJson>> get(IEntityJson entityJson) async {
    var _result = await _apiGet.get(entityJson);

    isLoading = false;
    notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getId(IEntityJson entityJson, int value) async {
    var _result = await _apiGet.getId(entityJson, value);

    isLoading = false;
    notifyListeners();
    return _result;
  }
}