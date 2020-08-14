import 'package:virtual_match/src/model/entity/IEntity.dart';

class TorneoModel implements IEntityJson {
  int idTorneo;
  int idOrganizacion;
  int idaTipoTorneo;
  int idaInscripcion;
  int idaTipoModalidad;
  int idaAsignacion;
  int cantidadJugadores;
  int horasFase;
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

  TorneoModel({
    this.idTorneo,
    this.idOrganizacion,
    this.idaTipoTorneo,
    this.idaInscripcion,
    this.idaTipoModalidad,
    this.idaAsignacion,
    this.cantidadJugadores,
    this.horasFase,
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
  });

  fromJson(Map<String, dynamic> json) => new TorneoModel(
        idTorneo: json["idTorneo"],
        idOrganizacion: json["idOrganizacion"],
        idaTipoTorneo: json["idaTipoTorneo"],
        idaInscripcion: json["idaInscripcion"],
        idaTipoModalidad: json["idaTipoModalidad"],
        idaAsignacion: json["idaAsignacion"],
        cantidadJugadores: json["cantidadJugadores"],
        horasFase: json["horasFase"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        hastag: json["hastag"],
        premios: json["premios"],
        organizador: json["organizador"],
        foto: json["foto"],
        fechaInicio: json["fechaInicio"],
        fechaFin: json["fechaFin"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
      );
}
