import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/dataMap.dart';
import 'package:virtual_match/src/api/clasification/ApiResource.dart';

class ApiDelete {
  Future<Map<String, dynamic>> delete(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());

    final apiRest = api['delete'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO

    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //FIN DE LA CLASE
