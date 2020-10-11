import 'package:virtual_match/src/model/entity/IEntity.dart';

class TorneoPersonalizar implements IEntityJson {
  int idTorneo;
  int idPartida;
  String fechaTorneo;
  int jugadorIzq;
  int jugadorDer;
  String nombreJugadorIzq;
  String psdnJugadorIzq;
  String fotoIzq;
  String nombreJugadorDer;
  String psdnJugadorDer;
  String fotoDer;

  TorneoPersonalizar({
    this.idTorneo,
    this.idPartida,
    this.fechaTorneo,
    this.jugadorIzq,
    this.jugadorDer,
    this.nombreJugadorIzq,
    this.psdnJugadorIzq,
    this.fotoIzq,
    this.nombreJugadorDer,
    this.psdnJugadorDer,
    this.fotoDer,
  });

  fromJson(Map<String, dynamic> json) => new TorneoPersonalizar(
        idTorneo: json["idTorneo"],
        idPartida: json["idPartida"],
        fechaTorneo: json["fechaTorneo"],
        jugadorIzq: json["jugadorIzq"],
        jugadorDer: json["jugadorDer"],
        nombreJugadorIzq: json["nombreJugadorIzq"],
        psdnJugadorIzq: json["psdnJugadorIzq"],
        fotoIzq: json["fotoIzq"],
        nombreJugadorDer: json["nombreJugadorDer"],
        psdnJugadorDer: json["psdnJugadorDer"],
        fotoDer: json["fotoDer"],
      );
}
