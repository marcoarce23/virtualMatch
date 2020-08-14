import 'package:virtual_match/src/model/entity/IEntity.dart';

class JugadorModel implements IEntityJson {
  int idJugador;
  int idOrganizacion;
  int idaDepartamento;
  int idLogin;
  int idaSexo;
  String idPsdn;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  String informacionComplementaria;
  String facebook;
  String twitter;
  String foto;

  JugadorModel(
      {this.idJugador,
      this.idOrganizacion,
      this.idaDepartamento,
      this.idLogin,
      this.idaSexo,
      this.idPsdn,
      this.nombre,
      this.apellido,
      this.correo,
      this.telefono,
      this.informacionComplementaria,
      this.facebook,
      this.twitter,
      this.foto});

  fromJson(Map<String, dynamic> json) => new JugadorModel(
        idJugador: json["idJugador"],
        idOrganizacion: json["idOrganizacion"],
        idaDepartamento: json["idaDepartamento"],
        idLogin: json["idLogin"],
        idaSexo: json["idaSexo"],
        idPsdn: json["idPsdn"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        telefono: json["telefono"],
        informacionComplementaria: json["informacionComplementaria"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        foto: json["foto"],
      );
}
