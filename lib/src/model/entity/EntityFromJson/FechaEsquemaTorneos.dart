import 'package:virtual_match/src/model/entity/IEntity.dart';

class FechaEsquemaTorneos implements IEntityJson {
  String fecha;
  String jugador1;
  String goles;
  String jugador2;
  String grupo;
  String cadena;

  FechaEsquemaTorneos({
    this.fecha,
    this.jugador1,
    this.goles,
    this.jugador2,
    this.grupo,
    this.cadena,
  });

  fromJson(Map<String, dynamic> json) => new FechaEsquemaTorneos(
        fecha: json["fecha"],
        jugador1: json["jugador1"],
        goles: json["goles"],
        jugador2: json["jugador2"],
        grupo: json["grupo"],
        cadena: json["cadena"],
      );
}
