import 'package:virtual_match/src/model/entity/IEntity.dart';

class JugadorModelList implements IEntityJson {
  int idJugador;
  int idOrganizacion;
  int idaDepartamento;
  int idLogin;
  int idaSexo;
  String idPsdn;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  String informacionComplementaria;
  String facebook;
  String twitter;
  String foto;

  JugadorModelList(
      {this.idJugador,
      this.idOrganizacion,
      this.idaDepartamento,
      this.idLogin,
      this.idaSexo,
      this.idPsdn,
      this.nombre,
      this.apellido,
      this.correo,
      this.telefono,
      this.informacionComplementaria,
      this.facebook,
      this.twitter,
      this.foto});

  fromJson(Map<String, dynamic> json) => new JugadorModelList(
        idJugador: json["idJugador"],
        idOrganizacion: json["idOrganizacion"],
        idaDepartamento: json["idaDepartamento"],
        idLogin: json["idLogin"],
        idaSexo: json["idaSexo"],
        idPsdn: json["idPsdn"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        telefono: json["telefono"],
        informacionComplementaria: json["informacionComplementaria"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        foto: json["foto"],
      );
}

class JugadorEquipoModelList implements IEntityJson {
  int idEquipo;
  String nombreEquipo;
  String detalle;

  String foto;
  int idJugador;
  String nombreJugador;
  String psdnJugador;
  String telefonoJugador;
  int agrupador;
  int esCapitan;
  int estado;

  JugadorEquipoModelList({
    this.idEquipo,
    this.nombreEquipo,
    this.detalle,
    this.foto,
    this.idJugador,
    this.nombreJugador,
    this.psdnJugador,
    this.telefonoJugador,
    this.agrupador,
    this.esCapitan,
    this.estado,
  });

  fromJson(Map<String, dynamic> json) => new JugadorEquipoModelList(
        idEquipo: json["idEquipo"],
        nombreEquipo: json["nombreEquipo"],
        detalle: json["detalle"],
        foto: json["foto"],
        idJugador: json["idJugador"],
        nombreJugador: json["nombreJugador"],
        psdnJugador: json["psdnJugador"],
        telefonoJugador: json["telefonoJugador"],
        agrupador: json["agrupador"],
        esCapitan: json["esCapitan"],
        estado: json["estado"],
      );
}
