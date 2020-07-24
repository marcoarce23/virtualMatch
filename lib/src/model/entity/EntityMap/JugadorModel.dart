import 'package:virtual_match/src/model/entity/IEntity.dart';

class JugadorModel implements IEntityMap {
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
  String user;

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
      this.user});

  Map<String, dynamic> toJson() => {
        "ID_JUGADOR": idJugador,
        "ID_ORGANIZACION": idOrganizacion,
        "IDA_DEPARTAMENTO": idaDepartamento,
        "ID_LOGIN": idLogin,
        "ID_PSDN": idPsdn,
        "NOMBRE": nombre,
        "APELLIDO": apellido,
        "CORREO": correo,
        "TELEFONO": telefono,
        "IDA_SEXO": idaSexo,
        "INFORMACION_COMPLEMENTARIA": informacionComplementaria,
        "FACEBOOK": facebook,
        "TWITTER": twitter,
        "FOTO": foto,
        "USUARIO": user,
      };
}
