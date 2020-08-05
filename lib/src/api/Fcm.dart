import 'package:virtual_match/src/model/entity/EntityMap/FcmModel.dart';

import 'DataMap.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_match/src/model/util/Const.dart';

class FCM {
  Future<Map<String, dynamic>> sebnFCM(FcmModel fcmModel) async {
    String sJSON =
        '{"to": "${fcmModel.token}","notification": {"title": ${fcmModel.title}, "body": "${fcmModel.body}"}, "data":{"data": "${fcmModel.data}"}}';
    String _body = sJSON;
    //print('body: $_body');
    final url = urlFCM;
    //print('url: $url');
    final response = await http.post(url,
        headers: {"Authorization": keyFCM, "Content-Type": contentTypeJSON},
        body: _body);
    if (response.statusCode == 200) {
    } else {}
    //print('ENvio FCM ------: ${response.headers} ---- ${response.body} ----  ${response.statusCode} ---- ${response.request}');
    return dataMap(response);
  }
}
