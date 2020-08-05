import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/provider/notification/ApiAdd.dart';
import 'package:virtual_match/src/provider/notification/ApiUpdate.dart';
import 'package:virtual_match/src/provider/notification/ApiDelete.dart';

class NotificationService with ChangeNotifier {
  bool _isLoading = true;

  final _apiAdd = new ApiAdd();
  final _apiDelete = new ApiDelete();
  final _apiUpdate = new ApiUpdate();

  Future<Map<String, dynamic>> repository(IEntityMap entity) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    _isLoading = true;
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
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
