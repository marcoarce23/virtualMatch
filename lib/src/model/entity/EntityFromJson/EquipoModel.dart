import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  EquipoModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new EquipoModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
