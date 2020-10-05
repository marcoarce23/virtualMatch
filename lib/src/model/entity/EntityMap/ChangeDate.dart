import 'package:virtual_match/src/model/entity/IEntity.dart';

class ChangeDate implements IEntityMap {
  @override
  StateEntity states;
  int identificador;
  int idTorneo;
  int idJugador;
  String fecha;

  ChangeDate({
    this.states = StateEntity.None,
    this.identificador,
    this.idTorneo,
    this.idJugador,
    this.fecha,
  });

  Map<String, dynamic> toJson() => {
        "identificador": identificador,
        "idTorneo": idTorneo,
        "idJugador": idJugador ?? 1,
        "fecha": fecha,
      };
}
