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
  String usuario;

  NoticiaEventoModel(
      {this.states = StateEntity.None,
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
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_NOTICIA_EVENTO": idNoticiaEvento,
        "ID_ORGANIZACION": idOrganizacion,
        "ID_PERSONAL": idPersonal,
        "TITULO": titulo,
        "OBJETIVO": objetivo,
        "DIRIGIDOA": dirigidoA,
        "UBICACION_URL": ubicacionUrl,
        "FECHA": fecha,
        "HORA": hora,
        "FOTO": foto,
        "USUARIO": usuario,
      };
}
