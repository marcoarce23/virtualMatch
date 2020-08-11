
import 'package:virtual_match/src/model/entity/IEntity.dart';

class RankingModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  RankingModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new RankingModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
