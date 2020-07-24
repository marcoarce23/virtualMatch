import 'package:virtual_match/src/model/entity/IEntity.dart';

class ClasificadorModel implements IEntityJson {
  int id;
  String nombre;
  String detalle;

  ClasificadorModel({this.id, this.nombre, this.detalle});

  fromJson(Map<String, dynamic> json) => new ClasificadorModel(
        id: json["ID"],
        nombre: json["NOMBRE"],
        detalle: json["DETALLE"],
      );
}

class LoginModel implements IEntityJson {
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

  LoginModel(
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

  fromJson(Map<String, dynamic> json) => new LoginModel(
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

class EventModel implements IEntityJson {
  int idcovEvento;
  int idcovInstitucion;
  int idcovPersonal;
  String eveTitulo;
  String eveObjetivo;
  String eveDirigidoA;
  String eveExpositor;
  String eveUbicacion;
  String eveFecha;
  String eveHora;
  String eveFoto;
  String usuario;

  EventModel(
      {this.idcovEvento = 0,
      this.idcovInstitucion,
      this.idcovPersonal,
      this.eveTitulo,
      this.eveObjetivo,
      this.eveDirigidoA,
      this.eveExpositor,
      this.eveUbicacion,
      this.eveFecha,
      this.eveHora,
      this.eveFoto,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new EventModel(
        idcovEvento: json["IDCOV_EVENTO"],
        idcovInstitucion: json["IDCOV_INSTITUCION"],
        idcovPersonal: json["IDCOV_PERSONAL"],
        eveTitulo: json["EVE_TITULO"],
        eveObjetivo: json["EVE_OBJETIVO"],
        eveDirigidoA: json["EVE_DIRIGIDOA"],
        eveExpositor: json["EVE_EXPOSITOR"],
        eveUbicacion: json["EVE_UBICACION"],
        eveFecha: json["EVE_FECHA"],
        eveHora: json["EVE_HORA"],
        eveFoto: json["EVE_FOTO"],
        usuario: json["USUARIO"],
      );
}

class MultimedyModel implements IEntityJson {
  int idcovMultimedia;
  int idaCategoria;
  int idaCovInstitucion;
  int idaTIpoMaterial;
  String mulTitulo;
  String mulResumen;
  String detFechaInicio;
  String detFechaFin;
  String mulEnlace;
  String usuario;
  String tipoMaterial;

  MultimedyModel(
      {this.idcovMultimedia,
      this.idaCategoria = 0,
      this.idaCovInstitucion,
      this.idaTIpoMaterial,
      this.mulTitulo,
      this.mulResumen,
      this.detFechaInicio,
      this.detFechaFin,
      this.mulEnlace,
      this.tipoMaterial,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new MultimedyModel(
        idcovMultimedia: json["IDCOV_MULTIMEDIA"],
        idaCategoria: json["IDA_CATEGORIA"],
        idaTIpoMaterial: json["IDA_TIPOMATERIAL"],
        idaCovInstitucion: json["IDCOV_INSTITUCION"],
        mulTitulo: json["MUL_TITULO"],
        mulResumen: json["MUL_RESUMEN"],
        detFechaInicio: json["MUL_FECHAINICIO"],
        detFechaFin: json["MUL_FECHAFIN"],
        mulEnlace: json["MUL_ENLACE"],
        tipoMaterial: json["TIPO_MATERIAL"],
        usuario: json["USUARIO"],
      );
}
