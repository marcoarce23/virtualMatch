import 'package:virtual_match/src/model/entity/IEntity.dart';

class FormatoModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  FormatoModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new FormatoModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
