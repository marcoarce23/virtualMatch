import 'package:flutter/material.dart';
import 'package:virtual_match/src/api/clasification/ApiGet.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';

class ClasificadorService with ChangeNotifier {
  bool isLoading = true;
  final _apiGet = new ApiGet();

  Future<List<IEntityJson>> get(IEntityJson entityJson, int value) async {
    var _result = await _apiGet.get(entityJson, value);

    isLoading = false;
    notifyListeners();
    return _result;
  }
}
