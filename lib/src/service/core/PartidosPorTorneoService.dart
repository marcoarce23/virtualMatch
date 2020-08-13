import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtual_match/src/api/core/tourment/ApiGet.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';


class PartidosPorTorneoService with ChangeNotifier  {
  bool isLoading = true;

  final _apiGet = new ApiGet();
/*
  Future<Map<String, dynamic>> repository(IEntityMap entity) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    isLoading = true;
    switch (entity.states) {
      case StateEntity.Insert:
        result = await _apiAdd.add(entity);
        break;
      case StateEntity.Delete:
        result = await _apiDelete.delete(entity);
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
  */

  
Future<List<IEntityJson>> getPartidosTorneoX(IEntityJson entityJson, int value) async {
    var _result = await _apiGet.getPartidosTorneo(entityJson, value);
    isLoading = false;
    notifyListeners();    
    return _result;
  }



 
}
