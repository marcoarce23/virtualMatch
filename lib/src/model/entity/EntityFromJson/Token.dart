
import 'package:virtual_match/src/model/entity/IEntity.dart';

class Token implements IEntityJson {
  String llaveToken;
  String correo;
  String detalle;

  Token({this.correo, this.detalle, this.llaveToken});

  fromJson(Map<String, dynamic> json) => new Token(
        llaveToken: json["TOKEN"],
        correo: json["LOG_CORREO"],
        detalle: json["DETALLE"],
      );

  Map<String, dynamic> toJson() => {
        "TOKEN": llaveToken,
        "LOG_CORREO": correo,
        "DETALLE": detalle,
      };
}