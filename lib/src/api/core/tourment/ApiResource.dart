import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Torneo', ''],
  'get': [API + '/api/Torneo/getTodosLosTorneos', ''],
  'get1': [API + '/api/Torneo/getTodosLosTorneosSinFormato', ''],
  'delete': [API + '/api/Torneo', ''],
  'getId': [API + '/api/Torneo/getDatosPorTorneo', ''],
  'update': [API + '/api/Torneo', ''],
  'getPartidosPorTorneo': [API + '/api/Torneo/getPartidosPorTorneo', ''],
  'getTablaPosiciones': [API + '/api/Torneo/getTablaPosicionesTorneo', ''],
  'getTodosLosTorneos': [API + '/api/Torneo/getTodosLosTorneos', ''],
  'getTodosLosTorneosIniciados': [
    API + '/api/Torneo/getTodosLosTorneosIniciados',
    ''
  ],
  'getHistoricoTorneo': [API + '/api/Torneo/GetDatosHistoricoPorTorneo', ''],
};
