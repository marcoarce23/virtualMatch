import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Equipo/InscribirJugador', ''],
  'get': [API + '/api/Equipo', ''],
  'delete': [API + '/api/Equipo/InscribirJugador', ''],
  'getId': [API + '/api/equipo', ''],
  'update': [API + '/api/Equipo/InscribirJugador', ''],
  'getListaJugadores': [API + '/api/Jugador/getListaJugadores', ''],
  'getMiEquipo': [API + '/api/Equipo/getDevuelveEquipoPorIdJugador', ''],
  'getListarEquipos': [API + '/api/Equipo/getListarEquipos', ''],
};
