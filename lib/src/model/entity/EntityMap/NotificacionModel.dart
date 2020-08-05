
import 'package:virtual_match/src/model/entity/IEntity.dart';

class NotificacionModel implements IEntityMap {
  @override
  StateEntity states;
  int idNotificacion;
  int idOrganizacion;
  String titulo;
  String detalle;
  String foto;
  String usuario;

  NotificacionModel(
      {this.states = StateEntity.None,
      this.idNotificacion = 0,
      this.idOrganizacion,
      this.titulo,
      this.detalle,
      this.foto,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_NOTIFICACION": idNotificacion,
        "ID_ORGANIZACION": idOrganizacion,
        "TITULO": titulo,
        "DETALLE": detalle,
        "FOTO": foto,
        "USUARIO": usuario,
      };
}
