import 'package:http/http.dart' as http;
import 'package:virtual_match/src/api/DataMap.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/tourment/ApiResource.dart';

class ApiGet {
   Future<List<IEntityJson>> get(IEntityJson entity) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['get'][0].toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }




  Future<List<IEntityJson>> getId(IEntityJson entity, int value) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['getId'][0].toString() + '/' + value.toString();
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
      IEntityJson entity) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest =
        api['getTodosLosTorneos'][0].toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }


}
