import 'package:virtual_match/src/model/entity/IEntity.dart';

class JugadorModel implements IEntityMap, IEntityJson {
  @override
  StateEntity states;
  int idJugador;
  int idOrganizacion;
  int idaDepartamento;
  int idLogin;
  String idPsdn;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  int idaSexo;
  String informacionComplementaria;
  String facebook;
  String twitter;
  String foto;
  String usuarioAuditoria;

  JugadorModel(
      {this.states = StateEntity.None,
      this.idJugador = 0,
      this.idOrganizacion,
      this.idaDepartamento,
      this.idLogin,
      this.idPsdn,
      this.nombre,
      this.apellido,
      this.correo,
      this.telefono,
      this.idaSexo,
      this.informacionComplementaria,
      this.facebook,
      this.twitter,
      this.foto,
      this.usuarioAuditoria});

  Map<String, dynamic> toJson() => {
        "idJugador": idJugador,
        "idOrganizacion": idOrganizacion,
        "idaDepartamento": idaDepartamento,
        "idLogin": idLogin,
        "idPsdn": idPsdn,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "telefono": telefono,
        "idaSexo": idaSexo,
        "informacionComplementaria": informacionComplementaria,
        "facebook": facebook,
        "twitter": twitter,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria
      };

  fromJson(Map<String, dynamic> json) => new JugadorModel(
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

class JugadorModelPersonalizado implements IEntityJson {
  int idJugador;
  int idOrganizacion;
  int idaDepartamento;
  String departamento;
  int idLogin;
  String idPsdn;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  int idaSexo;
  String informacionComplementaria;
  String facebook;
  String twitter;
  String foto;
  int boot;

  JugadorModelPersonalizado(
      {this.idJugador,
      this.idOrganizacion,
      this.idaDepartamento,
      this.departamento,
      this.idLogin,
      this.idPsdn,
      this.nombre,
      this.apellido,
      this.correo,
      this.telefono,
      this.idaSexo,
      this.informacionComplementaria,
      this.facebook,
      this.twitter,
      this.foto,
      this.boot});

  Map<String, dynamic> toJson() => {
        "idJugador": idJugador,
        "idOrganizacion": idOrganizacion,
        "idaDepartamento": idaDepartamento,
        "departamento": departamento,
        "idLogin": idLogin,
        "idPsdn": idPsdn,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "telefono": telefono,
        "idaSexo": idaSexo,
        "informacionComplementaria": informacionComplementaria,
        "facebook": facebook,
        "twitter": twitter,
        "foto": foto,
        "boot": boot
      };

  fromJson(Map<String, dynamic> json) => new JugadorModelPersonalizado(
        idJugador: json["idJugador"],
        idOrganizacion: json["idOrganizacion"],
        idaDepartamento: json["idaDepartamento"],
        departamento: json["departamento"],
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
        boot: json["boot"],
      );
}
