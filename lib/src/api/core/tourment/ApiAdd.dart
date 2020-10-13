import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/entity/EntityMap/AsignacionModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/FormatoModel.dart';

import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/tourment/ApiResource.dart';
import 'package:virtual_match/src/api/dataMap.dart';

class ApiAdd {
  Future<Map<String, dynamic>> add(IEntityMap entity) async {
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest =
        api['add'][0].toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('url: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> changeDate(IEntityMap entity) async {
    print(entity.toJson());
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = api['updateFecha'][0]
        .toString(); // eventResourceAdd['add'][0].toString()   ;
    //RouteAdd().postEvent(); // METODO QUE OBTENFA EL POST DEL EVENTO; MULTIMEDIA, VOLUTNARIO; HORARIO
    print('url: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> reemplazarJugador(
      ReemplazarJugador entity) async {
    print(entity.toJson());
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = api['reemplazarFecha'][0].toString() +
        "/Torneo/" +
        entity.idTorneo.toString() +
        "/Posicion/" +
        entity.izqDer +
        "/Partido/" +
        entity.idPartido.toString() +
        "/Reemplazo/" +
        entity.idJugadorReemplazo.toString();
    print('url: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }

  Future<Map<String, dynamic>> ejecutarTorneoManual(
      FormatoModel entity, int grupo, int jugadoresPorGrupo) async {
    print(entity.toJson());
    String _body = json.encode(entity.toJson());
    print('body: $_body');
    final apiRest = api['ejecutarTorneoManual'][0].toString() +
        "/Torneo/" +
        entity.idTorneo.toString() +
        "/grupo/" +
        grupo.toString() +
        "/jugadores/" +
        jugadoresPorGrupo.toString();

    print('url: $apiRest');
    final response = await http.post(apiRest,
        headers: {"Content-Type": "application/json"}, body: _body);
    return dataMap(response);
  }
} //FIN DE LA CLASE
