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

class EquipoCapitanesModel implements IEntityJson {
  String nombre;
  String detalle;
  String foto;
  int agrupador;
  String jugadorCapitan;
  String telefono;
  String psdn;
  int idEquipo;


  EquipoCapitanesModel(
      {this.nombre,
      this.detalle,
      this.foto,
      this.agrupador,
      this.psdn,
      this.telefono,
      this.jugadorCapitan,
      this.idEquipo});

  fromJson(Map<String, dynamic> json) => new EquipoCapitanesModel(
        nombre: json["nombre"],
        detalle: json["detalle"],
        foto: json["foto"],
        agrupador: json["agrupador"],
        jugadorCapitan: json["jugadorCapitan"],
        telefono: json["telefono"],
        psdn: json["psdn"],
        idEquipo: json["idEquipo"],
      );
}
