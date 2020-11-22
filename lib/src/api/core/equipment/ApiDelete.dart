import 'package:http/http.dart' as http;
import 'package:virtual_match/src/api/core/equipment/ApiResource.dart';
import 'package:virtual_match/src/api/dataMap.dart';

class ApiDelete {
  Future<Map<String, dynamic>> delete(String agrupador, String jugador) async {
    final apiRest = api['delete'][0].toString() +
        '/' +
        agrupador +
        '/jugador/' +
        jugador; // eventResourceAdd['add'][0].toString()   ;
 
    final response = await http
        .delete(apiRest, headers: {"Content-Type": "application/json"});
    return dataMap(response);
  }
} //FIN DE LA CLASE
