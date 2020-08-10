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
  String fechaAuditoria;

  EquipoModel(
      {this.states = StateEntity.None,
      this.idEquipo = 0,
      this.idJugador,
      this.nombre,
      this.detalle,
      this.foto,
      this.usuarioAuditoria,
      this.fechaAuditoria});

  Map<String, dynamic> toJson() => {
        "idEquipo": idEquipo,
        "idJugador": idJugador,
        "nombre": nombre,
        "detalle": detalle,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
        "fechaAuditoria": fechaAuditoria
      };
}
