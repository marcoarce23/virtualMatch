import 'package:virtual_match/src/model/entity/IEntity.dart';

class AsignacionModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  AsignacionModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new AsignacionModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
