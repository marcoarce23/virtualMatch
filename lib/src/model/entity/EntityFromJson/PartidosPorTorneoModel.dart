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
  String iCorreo;
  String iFacebook;
  String iTwitter;
  String dCorreo;
  String dFacebook;
  String dTwitter;
  String iTelefono;
  String dTelefono;

  int iidJugador;
  int didJugador;

  PartidosPorTorneoModel(
      {this.iGoles,
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
      this.iCorreo,
      this.iFacebook,
      this.iTwitter,
      this.dCorreo,
      this.dFacebook,
      this.dTwitter,
      this.iTelefono,
      this.dTelefono,
      this.iidJugador,
      this.didJugador});

  fromJson(Map<String, dynamic> json) => new PartidosPorTorneoModel(
        iidJugador: json["iidJugador"],
        didJugador: json["didJugador"],
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
        fechaTorneo: DateTime.parse(json["fechaTorneo"]),
        nombreTorneo: json["nombreTorneo"],
        fechaPartido: DateTime.parse(json["fechaPartido"]),
        iCorreo: json["iCorreo"],
        iFacebook: json["iFacebook"],
        iTwitter: json["iTwitter"],
        dCorreo: json["dCorreo"],
        dFacebook: json["dFacebook"],
        dTwitter: json["dTwitter"],
        iTelefono: json["iTelefono"],
        dTelefono: json["dTelefono"],
      );
}
