import 'package:virtual_match/src/model/entity/IEntity.dart';

class NoticiaEventoModel implements IEntityJson {
  int idNoticiaEvento;
  int idOrganizacion;
  int idPersonal;
  String titulo;
  String objetivo;
  String dirigidoa;
  String ubicacionUrl;
  String fecha;
  String hora;
  String foto;

  NoticiaEventoModel(
      {this.idNoticiaEvento,
      this.idOrganizacion,
      this.idPersonal,
      this.titulo,
      this.objetivo,
      this.dirigidoa,
      this.ubicacionUrl,
      this.fecha,
      this.hora,
      this.foto});

  fromJson(Map<String, dynamic> json) => new NoticiaEventoModel(
        idNoticiaEvento: json["idNoticiaEvento"],
        idOrganizacion: json["idOrganizacion"],
        idPersonal: json["idPersonal"],
        titulo: json["titulo"],
        objetivo: json["objetivo"],
        dirigidoa: json["dirigidoa"],
        ubicacionUrl: json["ubicacionUrl"],
        fecha: json["fecha"],
        hora: json["hora"],
        foto: json["foto"],
      );
}
