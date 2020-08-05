import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/tourment/ApiAdd.dart';
import 'package:virtual_match/src/api/core/tourment/ApiUpdate.dart';
import 'package:virtual_match/src/api/core/tourment/ApiDelete.dart';

class TourmentService with ChangeNotifier {
  bool isLoading = true;

  final _apiAdd = new ApiAdd();
  final _apiDelete = new ApiDelete();
  final _apiUpdate = new ApiUpdate();

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

// METODO GET LIST
//  List<IEntity<String, dynamic>> service(IEntityMap entity) async {
//     var result;
//     print('STATE ENTIRY: ${entity.states}');

//     isLoading = true;
//     switch (entity.states) {
//       case StateEntity.Insert:
//         result = await _apiAdd.add(entity);
//         break;
//       case StateEntity.Delete:
//         result = await _apiDelete.delete(entity);
//         break;
//       case StateEntity.Update:
//         result = await _apiUpdate.update(entity);
//         break;
//       default:
//     }

    ///
    ///
    ///
    ///
////
    ///
    ///
    ///
    print('DEL VALOR DE EVENT BLOC: $result');
    isLoading = false;
    notifyListeners();
    return result;
  }
}
