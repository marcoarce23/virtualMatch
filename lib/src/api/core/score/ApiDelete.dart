import 'package:http/http.dart' as http;
import 'package:virtual_match/src/api/core/score/ApiResource.dart';
import 'package:virtual_match/src/api/dataMap.dart';

class ApiDelete {
  Future<Map<String, dynamic>> delete(String id, String usuario) async {
    final apiRest = api['delete'][0].toString() +
        '/' +
        id +
        '/usuario/' +
        usuario; // eventResourceAdd['add'][0].toString()   ;
    print('url: $apiRest');
    final response = await http
        .delete(apiRest, headers: {"Content-Type": "application/json"});
    return dataMap(response);
  }
} //FIN DE LA CLASE
