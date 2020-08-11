import 'package:virtual_match/src/model/entity/IEntity.dart';

class NotidicacionModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  NotidicacionModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new NotidicacionModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
