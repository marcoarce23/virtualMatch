import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityJson {
  String nombre;
  String detalle;
  String foto;
  int agrupador;

  EquipoModel({this.nombre, this.detalle, this.foto, this.agrupador});

  fromJson(Map<String, dynamic> json) => new EquipoModel(
        nombre: json["nombre"],
        detalle: json["detalle"],
        foto: json["foto"],
        agrupador: json["agrupador"],
      );
}
