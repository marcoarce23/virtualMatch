import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Clasificador', ''],
  'get': [API + '/api/Clasificador/getClasificador', ''],
  'delete': [API + '/api/Clasificador', ''],
  'getId': [API + '/api/Torneo/getDatosPorTorneo', ''],
  'update': [API + '/api/Clasificador', ''],
  'getPartidosPorTorneo': [API + '/api/Torneo/getPartidosPorTorneo', ''],
  'getTablaPosiciones': [API + '/api/Torneo/getTablaPosicionesTorneo', ''],
  'getTodosLosTorneos': [API + '/api/Torneo/getTodosLosTorneos', ''],
};
