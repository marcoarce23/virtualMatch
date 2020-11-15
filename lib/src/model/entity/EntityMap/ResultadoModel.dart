import 'package:virtual_match/src/model/entity/IEntity.dart';

class ResultadoModel implements IEntityMap {
  @override
  StateEntity states;
  int idResultado;
  int gol1;
  int gol2;
  String foto;
  String usuarioAuditoria;

  ResultadoModel({
    this.states = StateEntity.None,
    this.idResultado,
    this.gol1,
    this.gol2,
    this.foto,
    this.usuarioAuditoria,
  });

  Map<String, dynamic> toJson() => {
        "idResultado": idResultado,
        "gol1": gol1,
        "gol2": gol2,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
      };
}


class ResultadoGolAsistenciaModel implements IEntityMap {
  @override
  StateEntity states;
  int idTorneo;
  int idJugador;
  int idJugadorCapitan;
  int gol;
  int golAsistencia;


  ResultadoGolAsistenciaModel({
    this.states = StateEntity.None,
    this.idTorneo,
    this.idJugador,
    this.idJugadorCapitan,
    this.gol,
    this.golAsistencia,
  });

  Map<String, dynamic> toJson() => {
        "idTorneo": idTorneo,
        "idJugador": idJugador,
        "idJugadorCapitan": idJugadorCapitan,
        "gol": gol,
        "golAsistencia": golAsistencia,
      };
}
