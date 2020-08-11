import 'package:virtual_match/src/model/entity/IEntity.dart';

class LoginModel implements IEntityMap {
  @override
  StateEntity states;
  int idLogin;
  String contrasenia;
  int estado;
  DateTime fechaRegistro;
  String tipoIngreso;
  String correo;
  String avatar;
  String persona;
  String usuario;

  LoginModel(
      {this.states = StateEntity.None,
      this.idLogin,
      this.contrasenia,
      this.estado,
      this.fechaRegistro,
      this.tipoIngreso,
      this.correo,
      this.avatar,
      this.persona,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_LOGIN": idLogin,
        "CONTRASENIA": contrasenia,
        "ESTADO": estado,
        "FECHA_REGISTRO": fechaRegistro,
        "TIPO_INGRESO": tipoIngreso,
        "CORREO": correo,
        "AVATAR": avatar,
        "PERSONA": persona,
        "USUARIO": usuario,
      };
}
