import 'package:virtual_match/src/model/entity/IEntity.dart';

class HistoricoTorneoModel implements IEntityJson {
  int nro;
  String fecha;
  String jugador1;
  String goles;
  String jugador2;

  HistoricoTorneoModel(
      {this.fecha, this.goles, this.jugador1, this.jugador2, this.nro});

  fromJson(Map<String, dynamic> json) => new HistoricoTorneoModel(
        nro: json["nro"],
        fecha: json["fecha"],
        jugador1: json["jugador1"],
        goles: json["goles"],
        jugador2: json["jugador2"],
      );
}
