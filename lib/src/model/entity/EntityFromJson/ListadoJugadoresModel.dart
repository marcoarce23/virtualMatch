
import '../IEntity.dart';

class ListadoJugadoresModel   implements IEntityJson {
        int idEquipo;
    int idDepartamento;
    int idSexo;
    dynamic departamento;
    String nombreJugador;
    String apellidoJugador;
    String correo;
    String telefono;
    dynamic sexo;
    String informacionJugador;
    String facebook;
    String twitter;
    String fotoJugador;
    String nombreEquipo;
    String detalleEquipo;
    String fotoEquipo;

ListadoJugadoresModel({
        this.idEquipo,
        this.idDepartamento,
        this.idSexo,
        this.departamento,
        this.nombreJugador,
        this.apellidoJugador,
        this.correo,
        this.telefono,
        this.sexo,
        this.informacionJugador,
        this.facebook,
        this.twitter,
        this.fotoJugador,
        this.nombreEquipo,
        this.detalleEquipo,
        this.fotoEquipo,
    });

  
   fromJson(Map<String, dynamic> json)=> new ListadoJugadoresModel(
    idEquipo: json["idEquipo"],
        idDepartamento: json["idDepartamento"],
        idSexo: json["idSexo"],
        departamento: json["departamento"],
        nombreJugador: json["nombreJugador"],
        apellidoJugador: json["apellidoJugador"],
        correo: json["correo"],
        telefono: json["telefono"],
        sexo: json["sexo"],
        informacionJugador: json["informacionJugador"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        fotoJugador: json["fotoJugador"],
        nombreEquipo: json["nombreEquipo"],
        detalleEquipo: json["detalleEquipo"],
        fotoEquipo: json["fotoEquipo"],
  );
}