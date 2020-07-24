import 'package:virtual_match/src/model/entity/EntityMap/SellersGroundModule.dart';

import 'DataList.dart';

class Readable {
//  Future<List<IReadable>> getAll(IReadable entity) async {
//     final _url = ApiGet.getEvent()[1];
//     final _primaryKey = ApiGet.getEvent()[0];

//     final List<IReadable> list = new List();
//     Map<String, dynamic> decodeData;
//     //print(_url);
//     // //print(_primaryKey);
//     final response = await http.get(_url);

//     if (response.statusCode == 200) {
//       Map dataMap = json.decode(response.body);
//       List<dynamic> listDynamic = dataMap[_primaryKey];
//       //      //print(listDynamic);
//       for (int i = 0; i < listDynamic.length; i++) {
//         decodeData = listDynamic[i];
//         list.add(entity.fromJson(decodeData));
//       }
//     } else {
//       Exception('Error: Status 400');
//     }
//     return list;
//   }

//   Future<List<IReadable>> getAId(IReadable entity) async {
//     final _url = ApiGet.getEvent()[0];
//     final _primaryKey = ApiGet.getEvent()[0];

//     final List<IReadable> list = new List();
//     Map<String, dynamic> decodeData;
//     //print(_url);
//     // //print(_primaryKey);
//     final response = await http.get(_url);

//     if (response.statusCode == 200) {
//       Map dataMap = json.decode(response.body);
//       List<dynamic> listDynamic = dataMap[_primaryKey];
//       //      //print(listDynamic);
//       for (int i = 0; i < listDynamic.length; i++) {
//         decodeData = listDynamic[i];
//         list.add(entity.fromJson(decodeData));
//       }
//     } else {
//       Exception('Error: Status 400');
//     }
//     return list;
//   }

  Future getListSellers() async {
    List<SellersGroundModule> projetcList = listSellers;
    return projetcList;
  }
}
