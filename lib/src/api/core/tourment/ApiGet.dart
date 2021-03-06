import 'package:http/http.dart' as http;
import 'package:virtual_match/src/api/DataMap.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/tourment/ApiResource.dart';

class ApiGet {
  Future<List<IEntityJson>> get(IEntityJson entity, int idJugador) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest =
        api['getTodosLosTorneos'][0].toString() + '/' + idJugador.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> get1(IEntityJson entity, int idJugador) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['get1'][0].toString() + '/' + idJugador.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getId(IEntityJson entity, int value) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getId1'][0].toString() + '/' + value.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getGanadores(IEntityJson entity) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getGanadores'][0].toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getPartidosTorneo(
      IEntityJson entity, int value) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest =
        api['getPartidosPorTorneo'][0].toString() + '/' + value.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getTablaPosiciones(
      IEntityJson entity, int value) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest =
        api['getTablaPosiciones'][0].toString() + '/' + value.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getTodosLosTorneos(
      IEntityJson entity, int idJugador) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest =
        api['getTodosLosTorneos'][0].toString() + '/' + idJugador.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getTodosLosTorneosIniciados(
      IEntityJson entity) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getTodosLosTorneosIniciados'][0].toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getHistoricoTorneo(
      IEntityJson entity, int idtorneo) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest =
        api['getHistoricoTorneo'][0].toString() + '/' + idtorneo.toString();
    print(_apiRest);
    final response = await http.get(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getFechasTorneo(
      IEntityJson entity, int idTorneo, int idJugador) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getFechasTorneo'][0].toString() +
        '/torneo/' +
        idTorneo.toString() +
        '/Jugador/' +
        idJugador.toString();
    print(_apiRest);
    final response = await http.get(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getFechasEsquemaPartidos(
      IEntityJson entity, int idTorneo) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getFechasEsquemaPartidos'][0].toString() +
        '/' +
        idTorneo.toString();

    print(_apiRest);
    final response = await http.get(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }

  Future<List<IEntityJson>> getDevuelveTorneoParaPersonalizar(
      IEntityJson entity, int idTorneo) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getDevuelveTorneoParaPersonalizar'][0].toString() +
        "/" +
        idTorneo.toString();
    print(_apiRest);
    final response = await http.get(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }
}
