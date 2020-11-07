import '../IEntity.dart';

class TablaPosicionesModel implements IEntityJson {
  int nro;
  int jugados;
  int idTorneo;
  int idEquipo;
  String imagenEquipo;
  String nombreEquipo;
  int puntaje;
  int empate;
  int perdida;
  int puntos;
  String tipoCompeticion;
  int grupo;
  int comodin;

  TablaPosicionesModel(
      {this.nro,
      this.jugados,
      this.idTorneo,
      this.idEquipo,
      this.imagenEquipo,
      this.nombreEquipo,
      this.puntaje,
      this.empate,
      this.perdida,
      this.puntos,
      this.tipoCompeticion,
      this.grupo,
      this.comodin});

  fromJson(Map<String, dynamic> json) => new TablaPosicionesModel(
        nro: json["nro"],
        jugados: json["jugados"],
        idTorneo: json["idTorneo"],
        idEquipo: json["idEquipo"],
        imagenEquipo: json["imagenEquipo"],
        nombreEquipo: json["nombreEquipo"],
        puntaje: json["puntaje"],
        empate: json["empate"],
        perdida: json["perdida"],
        puntos: json["puntos"],
        tipoCompeticion: json["tipoCompeticion"],
        grupo: json["grupo"],
        comodin: json["comodin"],
      );
}
