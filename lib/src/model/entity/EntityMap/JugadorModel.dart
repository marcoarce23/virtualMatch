import 'package:virtual_match/src/model/entity/IEntity.dart';

class JugadorModel implements IEntityMap {
  @override
  StateEntity states;
  int idJugador;
  int idOrganizacion;
  int idaDepartamento;
  int idLogin;
  String idPsdn;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  int idaSexo;
  String informacionComplementaria;
  String facebook;
  String twitter;
  String foto;
  String usuarioAuditoria;
  String fechaAuditoria;

  JugadorModel(
  {   this.states = StateEntity.None,
      this.idJugador = 0,
      this.idOrganizacion,
      this.idaDepartamento,
      this.idLogin,
      this.idPsdn,
      this.nombre,
      this.apellido,
      this.correo,
      this.telefono,
      this.idaSexo,
      this.informacionComplementaria,
      this.facebook,
      this.twitter,
      this.foto,
      this.usuarioAuditoria,
      this.fechaAuditoria});

  Map<String, dynamic> toJson() => {
        "idJugador": idJugador,
        "idOrganizacion": idOrganizacion,
        "idaDepartamento": idaDepartamento,
        "idLogin": idLogin,
        "idPsdn": idPsdn,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "telefono": telefono,
        "idaSexo": idaSexo,
        "informacionComplementaria": informacionComplementaria,
        "facebook": facebook,
        "twitter": twitter,
        "foto": foto,
        "usuarioAuditoria": usuarioAuditoria,
        "fechaAuditoria": fechaAuditoria,
      };
}
