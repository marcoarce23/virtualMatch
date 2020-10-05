import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Torneo', ''],
  'get': [API + '/api/Torneo/api/Torneo/getTodosLosTorneos/jugador', ''],
  'get1': [API + '/api/Torneo/getTodosLosTorneosSinFormato', ''],
  'delete': [API + '/api/Torneo', ''],
  'getId': [API + '/api/Torneo/getTodosLosTorneosSinFormato', ''],
  'update': [API + '/api/Torneo', ''],
  'getPartidosPorTorneo': [API + '/api/Torneo/getPartidosPorTorneo', ''],
  'getTablaPosiciones': [API + '/api/Torneo/getTablaPosicionesTorneo', ''],
  'getTodosLosTorneos': [API + '/api/Torneo/getTodosLosTorneos/jugador', ''],
  'getTodosLosTorneosIniciados': [
    API + '/api/Torneo/getTodosLosTorneosIniciados',
    ''
  ],
  'getHistoricoTorneo': [API + '/api/Torneo/GetDatosHistoricoPorTorneo', ''],
  'getFechasTorneo': [API + '/api/Torneo/getDevuelveFechasTorneos', ''],
  'getGanadores': [API + '/api/Torneo/getListaGanadores', ''],
  'updateFecha': [API + '/api/Torneo/ActualizaFechas', ''],
};
