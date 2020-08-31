import 'package:virtual_match/src/model/entity/IEntity.dart';

class FormatoModel implements IEntityMap {
  @override
  StateEntity states;
  int idFormato;
  int idTorneo;
  int idTipoCompeticion;
  int idaTipoTorneo;
  int idaInscripcion;
  int idaAsignacion;
  int cantidadJugadores;
  int idaTipoModalidad;
  String usuarioAuditoria;



  FormatoModel(
      {this.states = StateEntity.None,
   //   this.idFormato = 0,
      this.idTorneo,
      this.idTipoCompeticion,
      this.idaTipoTorneo,
      this.idaInscripcion,
      this.idaAsignacion,
      this.cantidadJugadores,
      this.idaTipoModalidad,
      this.usuarioAuditoria});

  Map<String, dynamic> toJson() => {
 //       "IdFormato": idFormato,
        "IdTorneo": idTorneo,
        "IdTipoCompeticion": idTipoCompeticion,
        "IdTipoTorneo": idaTipoTorneo,
        "IdInscripcion": idaInscripcion,
        "IdAsignacion": idaAsignacion,
        "CantidadJugadores": cantidadJugadores,
        "IdTipoModalidad": idaTipoModalidad,
        "UsuarioAuditoria": usuarioAuditoria,
      };
}

