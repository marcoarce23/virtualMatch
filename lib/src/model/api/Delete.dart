import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/api/apiDelete.dart';
import 'package:virtual_match/src/provider/dataMap.dart';

class Removable {
  Future<Map<String, dynamic>> delete(int id) async {
    //print('Eliminarrrr: $url');
    final response = await http.post(ApiDelete().toString());
    dataMap(response);
    return dataMap(response);
  }
}
