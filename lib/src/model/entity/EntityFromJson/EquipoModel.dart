import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityJson {
  String nombre;
  String detalle;
  String foto;
  int agrupador;

  EquipoModel({this.nombre, this.detalle, this.foto, this.agrupador});

  fromJson(Map<String, dynamic> json) => new EquipoModel(
        nombre: json["nombre"],
        detalle: json["detalle"],
        foto: json["foto"],
        agrupador: json["agrupador"],
      );
}

class EquipoCapitanesModel implements IEntityJson {
  String nombre;
  String detalle;
  String foto;
  int agrupador;
  String jugadorCapitan;
  String telefono;
  String psdn;
  int idEquipo;

  EquipoCapitanesModel(
      {this.nombre,
      this.detalle,
      this.foto,
      this.agrupador,
      this.psdn,
      this.telefono,
      this.jugadorCapitan,
      this.idEquipo});

  fromJson(Map<String, dynamic> json) => new EquipoCapitanesModel(
        nombre: json["nombre"],
        detalle: json["detalle"],
        foto: json["foto"],
        agrupador: json["agrupador"],
        jugadorCapitan: json["jugadorCapitan"],
        telefono: json["telefono"],
        psdn: json["psdn"],
        idEquipo: json["idEquipo"],
      );
}

class JugadorEquipoList implements IEntityJson {
  int idJugador;
  int esCapitan;
  String nombreEquipo;
  String detalleEquipo;
  String fotoEquipo;
  String psdn;
  String nombreCompleto;
  String correo;
  String telefono;
  String fotoJugador;

  JugadorEquipoList({
    this.idJugador,
    this.esCapitan,
    this.nombreEquipo,
    this.detalleEquipo,
    this.fotoEquipo,
    this.psdn,
    this.nombreCompleto,
    this.correo,
    this.telefono,
    this.fotoJugador,
  });

  fromJson(Map<String, dynamic> json) => new JugadorEquipoList(
        idJugador: json["idJugador"],
        esCapitan: json["esCapitan"],
        nombreEquipo: json["nombreEquipo"],
        detalleEquipo: json["detalleEquipo"],
        fotoEquipo: json["fotoEquipo"],
        psdn: json["psdn"],
        nombreCompleto: json["nombreCompleto"],
        correo: json["correo"],
        telefono: json["telefono"],
        fotoJugador: json["fotoJugador"],
      );
}
