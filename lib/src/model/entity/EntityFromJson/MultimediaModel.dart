import 'package:virtual_match/src/model/entity/IEntity.dart';

class MultimediaModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  MultimediaModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new MultimediaModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
