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
    });
  
  fromJson(Map<String, dynamic> json)=> new PartidosPorTorneoModel(
     iGoles: json["iGoles"],
        dGoles: json["dGoles"],
        iJugador: json["iJugador"],
        iFoto: json["iFoto"],
        dJugador: json["dJugador"],
        dFoto: json["dFoto"],
        estadoPartido: json["estadoPartido"],
        fechaTorneo: DateTime.parse(json["fechaTorneo"]),
        nombreTorneo: json["nombreTorneo"],
        fechaPartido: DateTime.parse(json["fechaPartido"]),);
}
