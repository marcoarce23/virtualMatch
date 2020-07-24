import 'package:http/http.dart' as http;
import 'DataMap.dart';

class FCM {
  Future<Map<String, dynamic>> sebnFCM(
      String token, String body, String data) async {
    String sJSON =
        '{"to": "$token","notification": {"title": "Lucia Te Cuida", "body": "$body"}, "data":{"data": "$data"}}';
    String _body = sJSON;
    //print('body: $_body');
    final url = 'https://fcm.googleapis.com/fcm/send';
    //print('url: $url');
    final response = await http.post(url,
        headers: {
          "Authorization":
              "key=AAAAxotDu0w:APA91bGSP8HuiwfdXoSb7cN0-U6WTW4eU_-Qj_c9Hd0msRD7becPLVV5rI0Ihj12KWeKYCc7pUuBTPr-R4Uq2oHgumcrj2ADS3_-rzKwTsT_567-1QFJ1NJjLmhNAa3Qt3Z3XG1rv3ol",
          "Content-Type": "application/json"
        },
        body: _body);
    if (response.statusCode == 200) {
    } else {}
    //print('ENvio FCM ------: ${response.headers} ---- ${response.body} ----  ${response.statusCode} ---- ${response.request}');
    return dataMap(response);
  }
}
