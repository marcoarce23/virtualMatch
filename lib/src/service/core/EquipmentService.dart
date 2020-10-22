import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/equipment/ApiGet.dart';

import 'package:virtual_match/src/api/core/equipment/ApiAdd.dart';
import 'package:virtual_match/src/api/core/equipment/ApiUpdate.dart';
import 'package:virtual_match/src/api/core/equipment/ApiDelete.dart';

class EquipmentService with ChangeNotifier {
  bool isLoading = true;

  final _apiAdd = new ApiAdd();
  final _apiDelete = new ApiDelete();
  final _apiUpdate = new ApiUpdate();
  final _apiState = new ApiState();

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
      case StateEntity.None:
        result = await _apiState.state(entity);
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
    notifyListeners();
    return _result;
  }

 Future<List<IEntityJson>> getEquipos(IEntityJson entityJson) async {
    var _result = await _apiGet.getEquipos(entityJson);

    isLoading = false;
    notifyListeners();
    notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getListarEquipos(IEntityJson entityJson) async {
    var _result = await _apiGet.getListarEquipos(entityJson);

    isLoading = false;
    notifyListeners();
    notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getTodosJugadores(
      IEntityJson entityJson, int value) async {
    var _result = await _apiGet.getTodosJugadores(entityJson, value);

    isLoading = false;
    notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getMisEquipos(
      IEntityJson entityJson, String idPlayer) async {
    var _result = await _apiGet.getMisEquipos(entityJson, idPlayer);

    isLoading = false;
    notifyListeners();
    notifyListeners();
    return _result;
  }
}
