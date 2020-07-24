import 'package:virtual_match/src/model/entity/IEntity.dart';

class AsignacionModel implements IEntityMap {
  @override
  StateEntity states;
  int idAsignacion;
  int idFormato;
  int idTipoAsignacion;
  String usuario;

  AsignacionModel(
      {this.states = StateEntity.None,
      this.idAsignacion = 0,
      this.idFormato,
      this.idTipoAsignacion,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_ASIGNACION": idAsignacion,
        "ID_FORMATO": idFormato,
        "IDA_TIPO_ASIGNACION": idTipoAsignacion,
        "USUARIO": usuario,
      };
}
