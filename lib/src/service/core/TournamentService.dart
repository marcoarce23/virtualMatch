import 'package:virtual_match/src/api/DataMap.dart';
import 'package:virtual_match/src/api/core/tourment/ApiGet.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/core/tourment/ApiAdd.dart';
import 'package:virtual_match/src/api/core/tourment/ApiUpdate.dart';
import 'package:virtual_match/src/api/core/tourment/ApiDelete.dart';
import 'package:virtual_match/src/api/core/format/ApiAdd.dart' as format;
import 'package:virtual_match/src/api/core/format/ApiUpdate.dart' as format1;
import 'package:virtual_match/src/api/core/format/ApiDelete.dart' as format2;
import 'package:http/http.dart' as http;

class TourmentService {
  //} with ChangeNotifier {
  bool isLoading = true;

  final _apiAdd = new ApiAdd();
  final _apiDelete = new ApiDelete();
  final _apiUpdate = new ApiUpdate();
  final _apiGet = new ApiGet();

  final _apiAddDetail = new format.ApiAdd();
  final _apiUpdateDetail = new format1.ApiUpdate();
  final _apiGetDetail = new format2.ApiDelete();

  Future<Map<String, dynamic>> repository(IEntityMap entity) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    isLoading = true;
    switch (entity.states) {
      case StateEntity.Insert:
        result = await _apiAdd.add(entity);
        break;
      case StateEntity.Update:
        result = await _apiUpdate.update(entity);
        break;
      default:
    }

    print('DEL VALOR DE EVENT BLOC: $result');
    isLoading = false;
    //  notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> repositoryDetail(IEntityMap entity) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    isLoading = true;
    switch (entity.states) {
      case StateEntity.Insert:
        result = await _apiAddDetail.add(entity);
        break;
      case StateEntity.Update:
        result = await _apiUpdateDetail.update(entity);
        break;
      default:
    }

    print('DEL VALOR DE EVENT BLOC: $result');
    isLoading = false;
    // notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> delete(String id, String usuario) async {
    var result;
    isLoading = true;
    result = await _apiDelete.delete(id, usuario);
    isLoading = false;
    //  notifyListeners();
    return result;
  }

  Future<List<IEntityJson>> get(IEntityJson entityJson) async {
    var _result = await _apiGet.get(entityJson);

    isLoading = false;
    //   notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> get1(IEntityJson entityJson, int idJugador) async {
    var _result = await _apiGet.get1(entityJson, idJugador);

    isLoading = false;
    //   notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getId(IEntityJson entityJson, int value) async {
    var _result = await _apiGet.getId(entityJson, value);

    isLoading = false;
    //   notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getTablaPosiciones(
      IEntityJson entityJson, int value) async {
    var _result = await _apiGet.getTablaPosiciones(entityJson, value);
    isLoading = false;
    //  notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getTodosLosTorneos(IEntityJson entityJson) async {
    var _result = await _apiGet.getTodosLosTorneos(entityJson);
    isLoading = false;
    //notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getTodosLosTorneosIniciados(
      IEntityJson entityJson) async {
    var _result = await _apiGet.getTodosLosTorneosIniciados(entityJson);
    isLoading = false;
    //notifyListeners();
    return _result;
  }

  Future<List<IEntityJson>> getTodosLosTorneosPersona(
      IEntityJson entityJson) async {
    var _result = await _apiGet.getTodosLosTorneos(entityJson);
    isLoading = false;
    //  notifyListeners();
    return _result;
  }

  Future<Map<String, dynamic>> execute(String url) async {
    final apiRest = url; // eventResourceAdd['add'][0].toString()   ;
    print('urlvvvvvvuuuuuuuuuu: $apiRest');
    final response = await http.post(apiRest);

    isLoading = false;
    //  notifyListeners();
    return dataMap(response);
  }

  Future<List<IEntityJson>> getHistoricoTorneo(
      IEntityJson entityJson, int idTorneo) async {
    var _result = await _apiGet.getHistoricoTorneo(entityJson, idTorneo);
    isLoading = false;
    return _result;
  }
}
