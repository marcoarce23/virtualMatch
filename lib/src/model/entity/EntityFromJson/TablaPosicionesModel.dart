import '../IEntity.dart';

class TablaPosicionesModel implements IEntityJson {
  int idTorneo;
  int idEquipo;
  String imagenEquipo;
  String nombreEquipo;
  int puntaje;
  int empate;
  int perdida;
  int puntos;

  TablaPosicionesModel({
    this.idTorneo,
    this.idEquipo,
    this.imagenEquipo,
    this.nombreEquipo,
    this.puntaje,
    this.empate,
    this.perdida,
    this.puntos,
  });

  fromJson(Map<String, dynamic> json) => new TablaPosicionesModel(
        idTorneo: json["idTorneo"],
        idEquipo: json["idEquipo"],
        imagenEquipo: json["imagenEquipo"],
        nombreEquipo: json["nombreEquipo"],
        puntaje: json["puntaje"],
        empate: json["empate"],
        perdida: json["perdida"],
        puntos: json["puntos"],
      );
}
