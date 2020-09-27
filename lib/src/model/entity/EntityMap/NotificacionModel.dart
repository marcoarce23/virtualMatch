import 'package:virtual_match/src/model/entity/IEntity.dart';

class NotificacionModel implements IEntityMap {
  @override
  StateEntity states;
  int idNotificacion;
  int idOrganizacion;
  String titulo;
  String detalle;
  String foto;
  String usuarioAuditoria;

  NotificacionModel(
      {this.states = StateEntity.None,
      this.idNotificacion = 0,
      this.idOrganizacion,
      this.titulo,
      this.detalle,
      this.foto,
      this.usuarioAuditoria});

  Map<String, dynamic> toJson() => {
        "idNotificacion": idNotificacion,
        "idOrganizacion": idOrganizacion,
        "titulo": titulo,
        "detalle": detalle,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
      };
}
