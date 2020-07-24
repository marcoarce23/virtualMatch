import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

final String userName = null;

String obtenerDepartamento(int idDepto)
{
   String _departamento = 'Cochabamba';
    
    if(idDepto == 54) _departamento= 'Pando'; 
     if(idDepto == 55) _departamento= 'Beni'; 
     if(idDepto == 56) _departamento= 'Santa Cruz'; 
     if(idDepto == 57) _departamento= 'La Paz'; 
     if(idDepto == 58) _departamento= 'Oruro'; 
     if(idDepto == 59) _departamento= 'Potosi'; 
     if(idDepto == 60) _departamento= 'Cochabamba'; 
     if(idDepto == 61) _departamento= 'Tarija'; 
     if(idDepto == 62) _departamento= 'Chuquisaca'; 
    return _departamento; 
}

// enviarNotificaciones(String urlGetToken, String clave, String titulo,
//     String valorTitulo, String subTitulo, String subTituloValor) {
//   Token entityToken;
//   final dataMapToken =
//       new Generic().getAll(new Token(), urlGetToken, primaryKeyGetToken);

//   dataMapToken.then((value) {
//     if (value.length > 0) {
//       for (int i = 0; i < value.length; i++) {
//         entityToken = value[i];
//         //    //print('entrooo las veces de: $entityToken');
//         new Generic().sebnFCM(entityToken.llaveToken, clave,
//             '$titulo - $valorTitulo - $subTitulo $subTituloValor - Fecha - ${DateTime.now()}');
//       }
//     }
//   });
// }

int daysInMonth(int month) {
  var now = DateTime.now();

  var lastDayDateTime = (month < 12)
      ? new DateTime(now.year, month + 1, 0)
      : new DateTime(now.year + 1, 1, 0);

  return lastDayDateTime.day;
}

Future<LatLng> getLocation() async {
  final Location location = Location();
  LocationData location1;
  LocationData locationResult;
  try {
    locationResult = await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION DENIED')
      print('Permission denied');
    else if (e.code == 'PERMISSION DENIED_NEVER_ASK')
      print('Permission denied enable ask');
  }
  location1 = locationResult;
  return LatLng(location1.latitude, location1.longitude);
}