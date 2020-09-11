import 'package:virtual_match/src/model/entity/IEntity.dart';

class LoginModel implements IEntityMap {
  @override
  StateEntity states;
  String foto;
  String nombre;
  String correo;
  String imei;
  String token;


    LoginModel(
      {this.states = StateEntity.None,
      this.foto,
      this.nombre,
      this.correo,
      this.imei,
      this.token});

  Map<String, dynamic> toJson() => {
        "foto": foto,
        "nombre": nombre,
        "correo": correo,
        "imei": imei,
        "token": token,
      };
}
