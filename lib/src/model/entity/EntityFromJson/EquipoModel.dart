import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityJson {
  String nombre;
  String detalle;
  String foto;
  int agrupador;
//   int idEquipo;
// int

// "idEquipo": 132,

//       "idJugador": 1,
//       "esCapitan": 0,
//       "estado": 3

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
//   int idEquipo;
// int

// "idEquipo": 132,

//       "idJugador": 1,
//       "esCapitan": 0,
//       "estado": 3

  EquipoCapitanesModel(
      {this.nombre,
      this.detalle,
      this.foto,
      this.agrupador,
      this.psdn,
      this.telefono,
      this.jugadorCapitan});

  fromJson(Map<String, dynamic> json) => new EquipoCapitanesModel(
        nombre: json["nombre"],
        detalle: json["detalle"],
        foto: json["foto"],
        agrupador: json["agrupador"],
        jugadorCapitan: json["jugadorCapitan"],
        telefono: json["telefono"],
        psdn: json["psdn"],
      );
}
