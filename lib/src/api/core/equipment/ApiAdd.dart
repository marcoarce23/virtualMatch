import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/equipment/ApiResource.dart';
import 'package:virtual_match/src/api/dataMap.dart';

class ApiAdd {
  Future<Map<String, dynamic>> add(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest =
        api['add'][0].toString(); 
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //FIN DE LA CLASE
