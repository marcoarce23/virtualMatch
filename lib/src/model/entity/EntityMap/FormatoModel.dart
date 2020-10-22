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
  int conBoot;
  int con11vs11;

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
      this.usuarioAuditoria,
      this.conBoot,
      this.con11vs11});

  Map<String, dynamic> toJson() => {
        //       "IdFormato": idFormato,
        "IdTorneo": idTorneo,
        "IdaTipoCompeticion": idTipoCompeticion,
        "IdaTipoTorneo": idaTipoTorneo,
        "IdaInscripcion": idaInscripcion,
        "IdaAsignacion": idaAsignacion,
        "CantidadJugadores": cantidadJugadores,
        "IdaTipoModalidad": idaTipoModalidad,
        "UsuarioAuditoria": usuarioAuditoria,
        "ConBoot": conBoot,
       "es11vs11" :con11vs11,
      };
}
