import 'package:virtual_match/src/model/entity/IEntity.dart';

class ProductModel implements IEntityMap {
  @override
  StateEntity states;

  int idBrandModel;
  String brand;
  String model;
  String type;
  String photo;
  String user;

  ProductModel(
      {this.states = StateEntity.None,
      this.idBrandModel = 0,
      this.brand,
      this.model,
      this.type,
      this.photo,
      this.user});

  Map<String, dynamic> toJson() => {
        "ID_MARCA_MODELO": idBrandModel,
        "MARCA": brand,
        "MODELO": model,
        "TIPO": type,
        "FOTO": photo,
        "USUARIO": user,
      };
}

class ProductDetailModel implements IEntityMap {
  @override
  StateEntity states;

  int idBrandModel;
  String brand;
  String model;
  String type;
  String photo;
  String user;

  ProductDetailModel(
      {this.states = StateEntity.None,
      this.idBrandModel = 0,
      this.brand,
      this.model,
      this.type,
      this.photo,
      this.user});

  Map<String, dynamic> toJson() => {
        "ID_MARCA_MODELO": idBrandModel,
        "MARCA": brand,
        "MODELO": model,
        "TIPO": type,
        "FOTO": photo,
        "USUARIO": user,
      };
}

class CatalogModel implements IEntityMap {
  @override
  StateEntity states;

  int idBrandModel;
  String brand;
  String model;
  String type;
  String photo;
  String user;

  CatalogModel(
      {this.states = StateEntity.None,
      this.idBrandModel = 0,
      this.brand,
      this.model,
      this.type,
      this.photo,
      this.user});

  Map<String, dynamic> toJson() => {
        "ID_MARCA_MODELO": idBrandModel,
        "MARCA": brand,
        "MODELO": model,
        "TIPO": type,
        "FOTO": photo,
        "USUARIO": user,
      };
}

class EventModel implements IEntityMap {
  @override
  StateEntity states;

  int idcovEvento;
  int idcovInstitucion;
  int idcovPersonal;
  String eveTitulo;
  String eveObjetivo;
  String eveDirigidoA;
  String eveExpositor;
  String eveUbicacion;
  String eveFecha;
  String eveHora;
  String eveFoto;
  String usuario;

  EventModel(
      {this.states = StateEntity.None,
      this.idcovEvento = 0,
      this.idcovInstitucion,
      this.idcovPersonal,
      this.eveTitulo,
      this.eveObjetivo,
      this.eveDirigidoA,
      this.eveExpositor,
      this.eveUbicacion,
      this.eveFecha,
      this.eveHora,
      this.eveFoto,
      this.usuario});

  Map<String, dynamic> toJson() => {
        "IDCOV_EVENTO": idcovEvento,
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDCOV_PERSONAL": idcovPersonal,
        "EVE_TITULO": eveTitulo,
        "EVE_OBJETIVO": eveObjetivo,
        "EVE_DIRIGIDOA": eveDirigidoA,
        "EVE_EXPOSITOR": eveExpositor,
        "EVE_UBICACION": eveUbicacion,
        "EVE_FECHA": eveFecha,
        "EVE_HORA": eveHora,
        "EVE_FOTO": eveFoto,
        "USUARIO": usuario,
      };
}

class MultimedyModel implements IEntityMap {
  @override
  StateEntity states;

  int idcovMultimedia;
  int idaCategoria;
  int idaCovInstitucion;
  int idaTIpoMaterial;
  String mulTitulo;
  String mulResumen;
  String detFechaInicio;
  String detFechaFin;
  String mulEnlace;
  String usuario;
  String tipoMaterial;

  MultimedyModel(
      {this.idcovMultimedia,
      this.idaCategoria = 0,
      this.idaCovInstitucion,
      this.idaTIpoMaterial,
      this.mulTitulo,
      this.mulResumen,
      this.detFechaInicio,
      this.detFechaFin,
      this.mulEnlace,
      this.tipoMaterial,
      this.usuario,
      this.states = StateEntity.None});

  Map<String, dynamic> toJson() => {
        "IDCOV_MULTIMEDIA": idcovMultimedia,
        "IDA_CATEGORIA": idaCategoria,
        "IDA_TIPOMATERIAL": idaTIpoMaterial,
        "IDCOV_INSTITUCION": idaCovInstitucion,
        "MUL_TITULO": mulTitulo,
        "MUL_RESUMEN": mulResumen,
        "MUL_FECHAINICIO": detFechaInicio,
        "MUL_FECHAFIN": detFechaFin,
        "MUL_ENLACE": mulEnlace,
        "TIPO_MATERIAL": tipoMaterial,
        "USUARIO": usuario
      };
}
