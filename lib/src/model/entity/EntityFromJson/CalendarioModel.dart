
import 'package:virtual_match/src/model/entity/IEntity.dart';

class CalendarioModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  CalendarioModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new CalendarioModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
