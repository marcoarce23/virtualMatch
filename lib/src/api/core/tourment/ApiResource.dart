import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Torneo', ''],
  'get': [API + '/api/Torneo', ''],
  'delete': [API + '/api/Torneo', ''],
  'getId': [API + '/api/Torneo/getDatosPorTorneo', ''],
  'update': [API + '/api/Torneo', ''],
  'getPartidosPorTorneo': [API + '/api/Torneo/getPartidosPorTorneo', ''],
  'getTablaPosiciones': [API + '/api/Torneo/getTablaPosicionesTorneo', ''],
  'getTodosLosTorneos': [API + '/api/Torneo/getTodosLosTorneos', ''],
};
