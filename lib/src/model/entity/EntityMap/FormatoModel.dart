import 'package:virtual_match/src/model/entity/IEntity.dart';

class FormatoModel implements IEntityMap {
  @override
  StateEntity states;
  int idFormato;
  int idTorneo;
  int idTipoCompeticion;
  String usuario;

  FormatoModel(
      {this.states = StateEntity.None,
      this.idFormato = 0,
      this.idTorneo,
      this.idTipoCompeticion,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_FORMATO": idFormato,
        "ID_TORNEO": idTorneo,
        "IDA_TIPO_COMPETICION": idTipoCompeticion,
        "USUARIO": usuario,
      };
}