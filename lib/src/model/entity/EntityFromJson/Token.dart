import 'package:virtual_match/src/model/entity/IEntity.dart';

class Token implements IEntityJson {
  String llaveToken;
  String correo;

  Token({this.correo, this.llaveToken});

  fromJson(Map<String, dynamic> json) => new Token(
        llaveToken: json["token"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "token": llaveToken,
        "correo": correo,
      };
}
