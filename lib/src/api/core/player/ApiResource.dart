import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Jugador', ''],
  'get': [API + '/api/Jugador', ''],
  'get1': [API + '/api/Jugador/Equipos', ''],
  'delete': [API + '/api/Jugador', ''],
  'getId': [API + '/api/Jugador', ''],
  'update': [API + '/api/Jugador', ''],
  'getMisJugadores': [
    API + '/api/Equipo/getDevuelveJugadoresEquipoPorIdJugador',
    ''
  ],
};
