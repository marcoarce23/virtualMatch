import 'package:virtual_match/src/model/entity/IEntity.dart';

class TorneoModel implements IEntityMap {
  @override
  StateEntity states;
  int idTorneo;
  int idOrganizacion;
  int idaTipoTorneo;
  int idaInscripcion;
  String nombre;
  String detalle;
  String hastag;
  String premios;
  String organizador;
  String foto;
  String fechaInicio;
  String fechaFin;
  String horaInicio;
  String horaFin;
  int idaAsignacion;
  int cantidadJugadores;
  int horasFase;
  int idaTipoModalidad;
  String usuarioAuditoria;
  String fechaAuditoria;

  TorneoModel(
      {this.states = StateEntity.None,
      this.idTorneo = 0,
      this.idOrganizacion,
      idaTipoTorneo,
      this.idaInscripcion,
      this.nombre,
      this.detalle,
      this.hastag,
      this.premios,
      this.organizador,
      this.foto,
      this.fechaInicio,
      this.fechaFin,
      this.horaInicio,
      this.horaFin,
      this.idaAsignacion,
      this.cantidadJugadores,
      this.horasFase,
      this.idaTipoModalidad,
      this.usuarioAuditoria,
      this.fechaAuditoria});

  Map<String, dynamic> toJson() => {
        "idTorneo": idTorneo,
        "idOrganizacion": idOrganizacion,
        "idaTipoTorneo": idaTipoTorneo,
        "idaInscripcion": idaInscripcion,
        "nombre": nombre,
        "detalle": detalle,
        "hastag": hastag,
        "premios": premios,
        "organizador": organizador,
        "foto": foto,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "horaInicio": horaInicio,
        "horaFin": horaFin,
        "idaAsignacion": idaAsignacion,
        "cantidadJugadores": cantidadJugadores,
        "horasFase": horasFase,
        "idaTipoModalidad": idaTipoModalidad,
        "usuarioAuditoria": usuarioAuditoria,
        "fechaAuditoria": fechaAuditoria
      };
}
