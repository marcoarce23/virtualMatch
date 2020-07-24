import 'package:virtual_match/src/model/entity/IEntity.dart';

class EquipoModel implements IEntityMap {
  @override
  StateEntity states;
  int idEquipo;
  int idJugador;
  String nombre;
  String detalle;
  String foto;
  String usuario;

  EquipoModel(
      {this.states = StateEntity.None,
      this.idEquipo = 0,
      this.idJugador,
      this.nombre,
      this.detalle,
      this.foto,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_EQUIPO": idEquipo,
        "ID_JUGADOR": idJugador,
        "NOMBRE": nombre,
        "DETALLE": detalle,
        "FOTO": foto,
        "USUARIO": usuario,
      };
}