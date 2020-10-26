import 'package:virtual_match/src/model/util/Const.dart';

Map<String, List<String>> api = {
  'add': [API + '/api/Resultado', ''],
  'get': [API + '/api/Resultado', ''],
  'delete': [API + '/api/Resultado', ''],
  'getId': [API + '/api/Resultado', ''],
  'update': [API + '/api/Resultado', ''],
  'updateLiga': [API + '/api/TorneoLiga/registroScored', ''],
  'updateFaseGrupo': [API + '/api/TorneoLiga/registroScoredFaseGrupo', ''],
  'updateEliminatoriaGrupo': [
    API + '/api/TorneoLiga/registroScoredEliminatoriaGrupo',
    ''
  ],
};
