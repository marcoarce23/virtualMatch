import 'package:virtual_match/src/model/entity/IEntity.dart';

class ResultadoModel implements IEntityMap {
  @override
  StateEntity states;

  int idResultado;
  int idTorneo;
  int idEliminatoria;
  int idEquipo1;
  int idEquipo2;
  int gol1;
  int gol2;
  String foto;
  String usuarioAuditoria;
  String fechaAuditoria;

  ResultadoModel(
      {this.states = StateEntity.None,
      this.idResultado,
      this.idTorneo,
      this.idEliminatoria,
      this.idEquipo1,
      this.idEquipo2,
      this.gol1,
      this.gol2,
      this.foto,
      this.usuarioAuditoria,
      this.fechaAuditoria});

  Map<String, dynamic> toJson() => {
        "idResultado": idResultado,
        "idTorneo": idTorneo,
        "idEliminatoria": idEliminatoria,
        "idEquipo1": idEquipo1,
        "idEquipo2": idEquipo2,
        "gol1": gol1,
        "gol2": gol2,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
        "fechaAuditoria": fechaAuditoria,
      };
}
