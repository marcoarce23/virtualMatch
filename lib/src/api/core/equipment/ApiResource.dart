import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'state': [API + '/api/Equipo/CambiarEstadoJugadorEquipo', ''],
  'add': [API + '/api/Equipo/InscribirJugador', ''],
  'get': [API + '/api/Equipo', ''],
  'getEquipos': [API + '/api/Equipo/getListarEquiposConCapitanes', ''],
  'delete': [API + '/api/Equipo/SalirEquipo', ''],
  'getId': [API + '/api/equipo', ''],
  'update': [API + '/api/Equipo/InscribirJugador', ''],
  'getListaJugadores': [API + '/api/Jugador/getListaJugadores', ''],
  'getMiEquipo': [API + '/api/Equipo/getDevuelveEquipoPorIdJugador', ''],
  'getListarEquipos': [API + '/api/Equipo/getListarEquipos', ''],
  'updates': [API + '/api/Equipo/modificar', ''],
};
