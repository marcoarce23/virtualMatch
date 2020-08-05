import 'package:virtual_match/src/model/entity/iEntity.dart';

class EventModel implements IEntityJson {
  String idUsuario;
  String idInstitucion;
  String nombrePersona;
  int idCreacionInstitucion;
  String nombreCreacionInstitucion;
  String correo;
  String nombreInstitucion;
  String usuario;
  String avatar;
  String password;
  String imei;
  String tokenDispositivo;
  String primeraVez;
  String idPersonal;

  EventModel(
      {this.idUsuario,
      this.idInstitucion,
      this.nombrePersona,
      this.idPersonal,
      this.nombreInstitucion,
      this.correo,
      this.usuario,
      this.password,
      this.avatar,
      this.imei,
      this.tokenDispositivo,
      this.idCreacionInstitucion,
      this.nombreCreacionInstitucion,
      this.primeraVez});

  fromJson(Map<String, dynamic> json) => new EventModel(
        idUsuario: json["ID_USUARIO"],
        idInstitucion: json["ID_INSTITUCION"],
        nombrePersona: json["NOMBRE_PERSONA"],
        nombreInstitucion: json["NOMBRE_INSTITUCION"],
        idCreacionInstitucion: json["ID_INSTITUCION_CREACION"],
        nombreCreacionInstitucion: json["NOMBRE_INSTITUCION_CREACION"],
        correo: json["CORREO"],
        usuario: json["USUARIO"],
        password: json["PASSWORD"],
        avatar: json["AVATAR"],
        imei: json["IMEI"],
        tokenDispositivo: json["TOKEN"],
        primeraVez: json["PRIMERA_VEZ"],
        idPersonal: json["IDCOV_PERSONAL"],
      );
}
