import '../IEntity.dart';

class ListaTorneoModel implements IEntityJson {
  int idTorneo;
  int idTipoTorneo;
  int idTipoInscripcion;
  int idAsignacion;
  int cantidadJugadores;
  int idTipoModalidad;
  int idTipoCompeticion;
  String tipoTorneo;
  String tipoInscripcion;
  String nombreTorneo;
  String detalle;
  String hashTag;
  String premios;
  String organizador;
  String foto;
  DateTime fechaInicio;
  String horaInicio;
  String tipoAsignacion;
  String tipoModalidad;
  String tipoCompeticion;
  int cantidadInscritos;
  int conBoot;
  int es11vs11;

  ListaTorneoModel(
      {this.idTorneo,
      this.idTipoCompeticion,
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
      this.cantidadInscritos,
      this.fechaInicio,
      this.horaInicio,
      this.tipoAsignacion,
      this.tipoModalidad,
      this.tipoCompeticion,
      this.conBoot,this.es11vs11});

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
      idTipoCompeticion: json["idTipoCompeticion"],
      hashTag: json["hashTag"],
      premios: json["premios"],
      organizador: json["organizador"],
      cantidadInscritos: json["cantidadInscritos"],
      foto: json["foto"],
      fechaInicio: DateTime.parse(json["fechaInicio"]),
      horaInicio: json["horaInicio"],
      tipoAsignacion: json["tipoAsignacion"],
      tipoModalidad: json["tipoModalidad"],
      tipoCompeticion: json["tipoCompeticion"],
      conBoot: json["conBoot"],
      es11vs11: json["es11vs11"]);
}
