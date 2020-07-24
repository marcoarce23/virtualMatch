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
  String usuario;

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
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_MULTIMEDIA": idMultimedia,
        "ID_ORGANIZACION": idOrganizacion,
        "IDA_CATEGORIA": idaCategoria,
        "TITULO": titulo,
        "RESUMEN": resumen,
        "FECHAINICIO": fechaInicio,
        "FECHAFIN": fechaFin,
        "ENLACE": enlace,
        "FOTO": enlace,
        "USUARIO": usuario,
      };
}
