import 'package:virtual_match/src/model/entity/EntityFromJson/Token.dart';
import 'package:virtual_match/src/service/crudService.dart';
import 'DataMap.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/util/Const.dart';

CrudService entityService = new CrudService();

enviarNotificaciones(String url, String clave, String titulo,
    String valorTitulo, String subTitulo, String subTituloValor) {
  Token _entityToken;
  entityService.get(new Token(), url).then((value) {
    if (value.length > 0) {
      for (int i = 0; i < value.length; i++) {
        _entityToken = value[i];

        new FCM().sebnFCM(
            _entityToken.llaveToken, //entityToken.llaveToken,
            clave,
            '$titulo: $valorTitulo - $subTitulo: $subTituloValor - Fecha: ${DateTime.now().toString().substring(0,10)}');
      }
    }
  });
}

class FCM {
  Future<Map<String, dynamic>> sebnFCM(
      String token, String body, String data) async {
    String sJSON =
        '{"to": "$token","notification": {"title": "Virtual Match", "body": "$data"}, "data":{"data": "$data"}}';
    String _body = sJSON;
  //  print('body: $_body');
    final response = await http.post(urlFCM,
        headers: {"Authorization": keyFCM, "Content-Type": contentTypeJSON},
        body: _body);

    if (response.statusCode == 200) {
    } else {}
    print(
        'ENvio FCM ------: ${response.headers} ---- ${response.body} ----  ${response.statusCode} ---- ${response.request}');
    return dataMap(response);
  }
}
