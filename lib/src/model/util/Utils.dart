// import 'package:flutter/services.dart';
// import 'package:location/location.dart';

final String userName = null;

String obtenerDepartamento(int idDepto) {
  String _departamento = 'Cochabamba';

  if (idDepto == 54) _departamento = 'Pando';
  if (idDepto == 55) _departamento = 'Beni';
  if (idDepto == 56) _departamento = 'Santa Cruz';
  if (idDepto == 57) _departamento = 'La Paz';
  if (idDepto == 58) _departamento = 'Oruro';
  if (idDepto == 59) _departamento = 'Potosi';
  if (idDepto == 60) _departamento = 'Cochabamba';
  if (idDepto == 61) _departamento = 'Tarija';
  if (idDepto == 62) _departamento = 'Chuquisaca';
  return _departamento;
}



int daysInMonth(int month) {
  var now = DateTime.now();

  var lastDayDateTime = (month < 12)
      ? new DateTime(now.year, month + 1, 0)
      : new DateTime(now.year + 1, 1, 0);

  return lastDayDateTime.day;
}

