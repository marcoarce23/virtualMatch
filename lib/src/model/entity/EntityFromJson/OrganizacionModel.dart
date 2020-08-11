import 'package:virtual_match/src/model/entity/IEntity.dart';

class OrganizacionModel implements IEntityJson {
  int idClasificador;
  String nombre;
  int estado;

  OrganizacionModel({this.idClasificador, this.nombre, this.estado});

  fromJson(Map<String, dynamic> json) => new OrganizacionModel(
        idClasificador: json["idClasificador"],
        nombre: json["nombre"],
        estado: json["estado"],
      );
}
