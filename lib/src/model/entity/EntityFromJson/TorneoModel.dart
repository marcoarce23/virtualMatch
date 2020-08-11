import 'package:virtual_match/src/model/entity/IEntity.dart';

class TorneoModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  TorneoModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new TorneoModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
