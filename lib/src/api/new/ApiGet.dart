import 'package:http/http.dart' as http;
import 'package:virtual_match/src/api/DataMap.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/api/new/ApiResource.dart';

class ApiGet {
  Future<List<IEntityJson>> get(IEntityJson entity, int value) async {
    final List<IEntityJson> list = new List();
    Map<String, dynamic> decodeData;

    final _apiRest = api['get'][0].toString() + '/' + value.toString();
    final response = await http.get(_apiRest);

    print(_apiRest);

    return getListIEntityJson(response, entity, decodeData, list);
  }
}