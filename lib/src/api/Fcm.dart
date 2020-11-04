import 'package:virtual_match/src/model/entity/EntityFromJson/Token.dart';
import 'package:virtual_match/src/service/crudService.dart';
import 'DataMap.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/util/Const.dart';

CrudService entityService = new CrudService();

enviarNotificaciones(String url, String clave, String titulo,
    String valorTitulo, String subTitulo, String subTituloValor) {
  Token entityToken;
  final dataMapToken = entityService.get(new Token(), url);

  dataMapToken.then((value) {
    if (value.length > 0) {
      for (int i = 0; i < value.length; i++) {
        entityToken = value[i];
        print('entrooo las veces de: $entityToken');
        new FCM().sebnFCM(entityToken.llaveToken, clave,
            '$titulo - $valorTitulo - $subTitulo $subTituloValor - Fecha - ${DateTime.now()}');
      }
    }
  });
}

class FCM {
  Future<Map<String, dynamic>> sebnFCM(
      String token, String body, String data) async {
    String sJSON =
        '{"to": "$token","notification": {"title": Comunidad Virtual Match, "body": "$body"}, "data":{"data": "$data"}}';
    String _body = sJSON;

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
