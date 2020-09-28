import 'package:virtual_match/src/model/entity/IEntity.dart';

class ListadoGanadores implements IEntityJson {
  int idtorneo;
  // ignore: non_constant_identifier_names
  String nombre_torneo;
  int equipo_1;
  String jugador_1;
  String foto_1;
  // ignore: non_constant_identifier_names
  int puntos_ganados_1;
  int equipo_2;
  String jugador_2;
  String foto_2;
  // ignore: non_constant_identifier_names
  int puntos_ganados_2;
  int equipo_3;
  String jugador_3;
  String foto_3;
  // ignore: non_constant_identifier_names
  int puntos_ganados_3;

  ListadoGanadores({
    this.idtorneo,
    // ignore: non_constant_identifier_names
    this.nombre_torneo,
    this.equipo_1,
    this.jugador_1,
    this.foto_1,
    // ignore: non_constant_identifier_names
    this.puntos_ganados_1,
    this.equipo_2,
    this.jugador_2,
    this.foto_2,
    // ignore: non_constant_identifier_names
    this.puntos_ganados_2,
    this.equipo_3,
    this.jugador_3,
    this.foto_3,
    // ignore: non_constant_identifier_names
    this.puntos_ganados_3,
  });

  fromJson(Map<String, dynamic> json) => new ListadoGanadores(
        idtorneo: json["idtorneo"],
        nombre_torneo: json["nombre_torneo"],
        equipo_1: json["equipo_1"],
        jugador_1: json["jugador_1"],
        foto_1: json["foto_1"],
        puntos_ganados_1: json["puntos_ganados_1"],
        equipo_2: json["equipo_2"],
        jugador_2: json["jugador_2"],
        foto_2: json["foto_2"],
        puntos_ganados_2: json["puntos_ganados_2"],
        equipo_3: json["equipo_3"],
        jugador_3: json["jugador_3"],
        foto_3: json["foto_3"],
        puntos_ganados_3: json["puntos_ganados_3"],
      );
}
