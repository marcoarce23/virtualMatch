import 'package:virtual_match/src/model/entity/IEntity.dart';

class ClasificadorModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  ClasificadorModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new ClasificadorModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
