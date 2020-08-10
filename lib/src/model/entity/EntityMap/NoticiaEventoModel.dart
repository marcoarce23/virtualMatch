import 'package:virtual_match/src/model/entity/IEntity.dart';

class NoticiaEventoModel implements IEntityMap {
  @override
  StateEntity states;
  int idNoticiaEvento;
  int idOrganizacion;
  int idPersonal;
  String titulo;
  String objetivo;
  String dirigidoA;
  String ubicacionUrl;
  String fecha;
  String hora;
  String foto;
  String usuarioAuditoria;
  String fechaAuditoria;

  NoticiaEventoModel(
  {
      this.states = StateEntity.None,
      this.idNoticiaEvento = 0,
      this.idOrganizacion,
      this.idPersonal,
      this.titulo,
      this.objetivo,
      this.dirigidoA,
      this.ubicacionUrl,
      this.fecha,
      this.hora,
      this.foto,
      this.usuarioAuditoria,
      this.fechaAuditoria
      }
      );

  Map<String, dynamic> toJson() => {
        "idNoticiaEvento": idNoticiaEvento,
        "idOrganizacion": idOrganizacion,
        "idPersonal": idPersonal,
        "titulo": titulo,
        "objetivo": objetivo,
        "dirigidoa": dirigidoA,
        "ubicacionUrl": ubicacionUrl,
        "fecha": fecha,
        "hora": hora,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
        "fechaAuditoria": fechaAuditoria,
      };
}
