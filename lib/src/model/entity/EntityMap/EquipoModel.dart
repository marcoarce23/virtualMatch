import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityMap {
  @override
  StateEntity states;
  int idEquipo;
  int idJugador;
  String nombre;
  String detalle;
  String foto;
  String usuarioAuditoria;
  int agrupador;
  int esCapitan;

  EquipoModel(
      {this.states = StateEntity.None,
      this.idEquipo = 0,
      this.idJugador,
      this.nombre,
      this.detalle,
      this.foto,
      this.usuarioAuditoria,
      this.agrupador,
      this.esCapitan});

  Map<String, dynamic> toJson() => {
        "idEquipo": idEquipo,
        "nombre": nombre,
        "detalle": detalle,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
        "idJugador": idJugador,
        "agrupador": agrupador,
        "esCapitan": esCapitan
      };
}
