import 'package:virtual_match/src/model/entity/IEntity.dart';

class NoticiaEventoModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  NoticiaEventoModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new NoticiaEventoModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
