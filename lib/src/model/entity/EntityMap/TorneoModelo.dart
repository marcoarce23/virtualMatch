import 'package:virtual_match/src/model/entity/IEntity.dart';

class TorneoModel implements IEntityMap {
  @override
  StateEntity states;
  int idTorneo;
  int idOrganizacion;
  String nombre;
  String detalle;
  String hastag;
  String premios;
  String organizador;
  String foto;
  String fechaInicio;
  String horaInicio;
  String usuarioAuditoria;

  TorneoModel(
      {this.states = StateEntity.None,
      this.idTorneo = 0,
      this.idOrganizacion,
      idaTipoTorneo,
      this.nombre,
      this.detalle,
      this.hastag,
      this.premios,
      this.organizador,
      this.foto,
      this.fechaInicio,
      this.horaInicio,
      this.usuarioAuditoria});

  Map<String, dynamic> toJson() => {
        "idTorneo": idTorneo,
        "idOrganizacion": idOrganizacion,
        "nombre": nombre,
        "detalle": detalle,
        "hastag": hastag,
        "premios": premios,
        "organizador": organizador,
        "foto": foto,
        "fechaInicio": fechaInicio,
        "horaInicio": horaInicio,
        "usuarioAuditoria": usuarioAuditoria,
      };
}
