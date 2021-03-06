import 'package:virtual_match/src/model/entity/IEntity.dart';

class ListaFechasTorneo implements IEntityJson {
  int id;
  // ignore: non_constant_identifier_names
  int nrO_FECHA;
  String torneo;
  DateTime fecha;
  String detalle;

  ListaFechasTorneo(
      {this.id,
      // ignore: non_constant_identifier_names
      this.nrO_FECHA,
      this.fecha,
      this.detalle,
      this.torneo});

  fromJson(Map<String, dynamic> json) => new ListaFechasTorneo(
        id: json["id"],
        nrO_FECHA: json["nrO_FECHA"],
        detalle: json["detalle"],
        torneo: json["torneo"],
        fecha: DateTime.parse(json["fecha"]),
      );
}
