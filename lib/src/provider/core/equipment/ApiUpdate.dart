import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/provider/dataMap.dart';
import 'package:virtual_match/src/provider/core/equipment/ApiResource.dart';

class ApiUpdateEvent {
  Future<Map<String, dynamic>> update(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = api['update'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('url: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //FIN DE LA CLASE
