import 'package:virtual_match/src/model/entity/IEntity.dart';

class JugadorModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  JugadorModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new JugadorModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
