import '../IEntity.dart';

class PartidosPorTorneoModel implements IEntityJson {
  int iGoles;
  int dGoles;
  String iJugador;
  String iFoto;
  String dJugador;
  String dFoto;
  String estadoPartido;
  DateTime fechaTorneo;
  String nombreTorneo;
  DateTime fechaPartido;
  int idEliminatoria;
  int idResultado;
  int idTorneo;

  int dIdJugador;
  int iIdJugador;

  PartidosPorTorneoModel({
    this.iGoles,
    this.dGoles,
    this.iJugador,
    this.iFoto,
    this.dJugador,
    this.dFoto,
    this.estadoPartido,
    this.fechaTorneo,
    this.nombreTorneo,
    this.fechaPartido,
    this.idEliminatoria,
    this.idResultado,
    this.idTorneo,
    this.dIdJugador,
    this.iIdJugador,
  });

  fromJson(Map<String, dynamic> json) => new PartidosPorTorneoModel(
        iGoles: json["iGoles"],
        dGoles: json["dGoles"],
        iJugador: json["iJugador"],
        iFoto: json["iFoto"],
        dJugador: json["dJugador"],
        dFoto: json["dFoto"],
        estadoPartido: json["estadoPartido"],
        idEliminatoria: json["iD_ELIMINATORIA"],
        idResultado: json["iD_RESULTADO"],
        idTorneo: json["iD_TORNEO"],
        dIdJugador: json["dIdJugador"],
        iIdJugador: json["iIdJugador"],
        fechaTorneo: DateTime.parse(json["fechaTorneo"]),
        nombreTorneo: json["nombreTorneo"],
        fechaPartido: DateTime.parse(json["fechaPartido"]),
      );
}
