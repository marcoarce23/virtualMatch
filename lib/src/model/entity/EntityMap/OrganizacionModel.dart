import 'package:virtual_match/src/model/entity/IEntity.dart';

class OrganizacionModel implements IEntityMap {
  @override
  StateEntity states;
  int idOrganizacion;
  String nombre;
  int idaPais;
  int idaDepartamento;
  String direccion;
  double lat;
  double lng;
  String telefono;
  String facebook;
  String twitter;
  String paginaWeb;
  String youtube;
  String correo;
  String informacionComplementaria;
  String foto;
  String user;

  OrganizacionModel(
      {this.states = StateEntity.None,
      this.idOrganizacion = 0,
      this.nombre,
      this.idaPais,
      this.idaDepartamento,
      this.direccion,
      this.lat,
      this.lng,
      this.telefono,
      this.facebook,
      this.twitter,
      this.paginaWeb,
      this.youtube,
      this.correo,
      this.informacionComplementaria,
      this.foto,
      this.user});

  Map<String, dynamic> toJson() => {
        "ID_ORGANIZACION": idOrganizacion,
        "NOMBRE_ORGANIZACION": nombre,
        "IDA_PAIS": idaPais,
        "IDA_DEPARTAMENTO": idaDepartamento,
        "DIRECCION": direccion,
        "LAT": lat,
        "LNG": lng,
        "TELEFONO": telefono,
        "FACEBOOK": facebook,
        "TWITTER": twitter,
        "PAGINA_WEB": paginaWeb,
        "YOUTUBE": youtube,
        "CORREO": correo,
        "INFORMACION_COMPLEMENTARIA": informacionComplementaria,
        "FOTO": foto,
        "USUARIO": user,
      };
}
