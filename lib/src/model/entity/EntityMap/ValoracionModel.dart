import 'package:virtual_match/src/model/entity/IEntity.dart';

class ValoracionModel implements IEntityMap {
  @override
  StateEntity states;
  int idValoracion;
  int idOrganizacion;
  int idObjeto;
  int idaTipo;
  String comentario;
  int meGusta;
  int meEncanta;
  int compartido;
  double ranking;
  String usuario;

  ValoracionModel(
      {this.states = StateEntity.None,
      this.idValoracion = 0,
      this.idOrganizacion,
      this.idObjeto,
      this.idaTipo,
      this.comentario,
      this.meGusta,
      this.meEncanta,
      this.compartido,
      this.ranking,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "ID_VALORACION": idValoracion,
        "ID_ORGANIZACION": idOrganizacion,
        "ID_OBJETO": idObjeto,
        "IDA_TIPO": idaTipo,
        "COMENTARIO": comentario,
        "MEGUSTA": meGusta,
        "MEENCANTA": meEncanta,
        "COMPARTIDO": compartido,
        "RANKING": ranking,
        "USUARIO": usuario,
      };
}
