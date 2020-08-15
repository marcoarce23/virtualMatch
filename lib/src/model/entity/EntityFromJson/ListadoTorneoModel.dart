import '../IEntity.dart';

class ListaTorneoModel implements IEntityJson {
  int idTorneo;
  int idTipoTorneo;
  int idTipoInscripcion;
  int idAsignacion;
  int cantidadJugadores;
  int idTipoModalidad;
  String tipoTorneo;
  String tipoInscripcion;
  String nombreTorneo;
  String detalle;
  String hashTag;
  String premios;
  String organizador;
  String foto;
  DateTime fechaInicio;
  DateTime fechaFin;
  String horaInicio;
  String horaFin;
  String tipoAsignacion;
  String tipoModalidad;

  ListaTorneoModel({
    this.idTorneo,
    this.idTipoTorneo,
    this.idTipoInscripcion,
    this.idAsignacion,
    this.cantidadJugadores,
    this.idTipoModalidad,
    this.tipoTorneo,
    this.tipoInscripcion,
    this.nombreTorneo,
    this.detalle,
    this.hashTag,
    this.premios,
    this.organizador,
    this.foto,
    this.fechaInicio,
    this.fechaFin,
    this.horaInicio,
    this.horaFin,
    this.tipoAsignacion,
    this.tipoModalidad,
  });

  fromJson(Map<String, dynamic> json) => new ListaTorneoModel(
        idTorneo: json["idTorneo"],
        idTipoTorneo: json["idTipoTorneo"],
        idTipoInscripcion: json["idTipoInscripcion"],
        idAsignacion: json["idAsignacion"],
        cantidadJugadores: json["cantidadJugadores"],
        idTipoModalidad: json["idTipoModalidad"],
        tipoTorneo: json["tipoTorneo"],
        tipoInscripcion: json["tipoInscripcion"],
        nombreTorneo: json["nombreTorneo"],
        detalle: json["detalle"],
        hashTag: json["hashTag"],
        premios: json["premios"],
        organizador: json["organizador"],
        foto: json["foto"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
        tipoAsignacion: json["tipoAsignacion"],
        tipoModalidad: json["tipoModalidad"],
      );
}
