import 'package:virtual_match/src/model/entity/IEntity.dart';

class NotificacionModel implements IEntityMap {
  @override
  StateEntity states;
  int idNotificacion;
  String titulo;
  String detalle;
  String foto;
  String usuario;

  NotificacionModel(
      {this.states = StateEntity.None,
      this.idNotificacion = 0,
      this.titulo,
      this.detalle,
      this.foto,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_NOTIFICACION": idNotificacion,
        "TITULO": titulo,
        "DETALLE": detalle,
        "FOTO": foto,
        "USUARIO": usuario,
      };
}
