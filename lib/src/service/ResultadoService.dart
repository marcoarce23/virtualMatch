import 'package:flutter/material.dart';
import 'package:virtual_match/src/api/Resultado/ApiAdd.dart';
import 'package:virtual_match/src/api/Resultado/ApiDelete.dart';
import 'package:virtual_match/src/api/Resultado/ApiGet.dart';
import 'package:virtual_match/src/api/Resultado/ApiUpdate.dart';

import 'package:virtual_match/src/model/entity/IEntity.dart';

class ResultadoService with ChangeNotifier {
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
      default:
    }

    print('DEL VALOR DE EVENT BLOC: $result');
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> update(IEntityMap entity, int id) async {
    var result;
    isLoading = true;
    result = await _apiUpdate.update(entity, id);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateLiga(IEntityMap entity) async {
    var result;
    isLoading = true;
    result = await _apiUpdate.updateLiga(entity);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateFaseGrupo(IEntityMap entity) async {
    var result;
    isLoading = true;
    result = await _apiUpdate.updateFaseGrupo(entity);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateEliminatoriaGrupo(
      IEntityMap entity) async {
    var result;
    isLoading = true;
    result = await _apiUpdate.updateEliminatoriaGrupo(entity);
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
