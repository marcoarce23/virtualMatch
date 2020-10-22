import 'package:virtual_match/src/model/entity/IEntity.dart';

class MultimediaModel implements IEntityMap {
  @override
  StateEntity states;
  int idMultimedia;
  int idOrganizacion;
  int idaCategoria;
  String titulo;
  String resumen;
  String fechaInicio;
  String fechaFin;
  String enlace;
  String foto;
  String usuarioAuditoria;

  MultimediaModel(
      {this.states = StateEntity.None,
      this.idMultimedia = 0,
      this.idOrganizacion,
      this.idaCategoria,
      this.titulo,
      this.resumen,
      this.fechaInicio,
      this.fechaFin,
      this.enlace,
      this.foto,
      this.usuarioAuditoria});

  Map<String, dynamic> toJson() => {
        "idMultimedia": idMultimedia,
        "idOrganizacion": idOrganizacion,
        "idaCategoria": idaCategoria,
        "titulo": titulo,
        "resumen": resumen,
        "fechainicio": fechaInicio,
        "fechafin": fechaFin,
        "enlace": enlace,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
      };
}
