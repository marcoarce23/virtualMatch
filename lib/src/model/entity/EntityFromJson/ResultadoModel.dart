
import 'package:virtual_match/src/model/entity/IEntity.dart';

class ResultadoModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  ResultadoModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new ResultadoModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
