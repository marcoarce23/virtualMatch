import 'package:virtual_match/src/model/entity/IEntity.dart';

class ReemplazarJugador implements IEntityMap {
  @override
  StateEntity states;
  int idTorneo;
  String izqDer;
  int idPartido;
  int idJugador;
  int idJugadorReemplazo;

  ReemplazarJugador({
    this.states = StateEntity.None,
    this.idTorneo,
    this.izqDer,
    this.idPartido,
    this.idJugador,
    this.idJugadorReemplazo,
  });

  Map<String, dynamic> toJson() => {
        "idTorneo": idTorneo,
        "izqDer": izqDer,
        "idPartido": idPartido,
        "idJugador": idJugador,
        "idJugadorReemplazo": idJugadorReemplazo,
      };
}
