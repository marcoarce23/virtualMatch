import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityJson {
  int idEquipo;
  int idJugador;
  String nombre;
  String detalle;
  String foto;


  EquipoModel(
      {this.idEquipo, this.idJugador, this.nombre, this.detalle, this.foto});

  fromJson(Map<String, dynamic> json) => new EquipoModel(
        idEquipo: json["idEquipo"],
        idJugador: json["idJugador"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        foto: json["foto"],
      );
}
