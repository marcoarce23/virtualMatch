import 'package:virtual_match/src/model/entity/IEntity.dart';

class NotificacionModel implements IEntityJson {
  int idNotificacion;
  String titulo;
  String detalle;
  String foto;
  String usuariocreacion;
  String fechacreacion;
  int idOrganizacion;

  NotificacionModel(
      {this.idNotificacion,
      this.titulo,
      this.detalle,
      this.usuariocreacion,
      this.fechacreacion,
      this.idOrganizacion});

  fromJson(Map<String, dynamic> json) => new NotificacionModel(
        idNotificacion: json["idNotificacion"],
        titulo: json["titulo"],
        detalle: json["detalle"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        idOrganizacion: json["idOrganizacion"],
      );
}
