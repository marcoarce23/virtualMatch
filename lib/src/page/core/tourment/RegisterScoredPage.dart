import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/PartidosPorTorneoModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/ResultadoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';

import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/ResultadoService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'TourmentPage.dart';

// ignore: must_be_immutable
class RegisterScoredPage extends StatefulWidget {
  final int idTorneo;
  PartidosPorTorneoModel entity;

  RegisterScoredPage({Key key, @required this.entity, @required this.idTorneo})
      : super(key: key);

  @override
  _RegisterScoredPageState createState() => _RegisterScoredPageState();
}

class _RegisterScoredPageState extends State<RegisterScoredPage> {
  final prefs = new Preferense();
  File photo;
  String image = IMAGE_DEFAULT;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ListaTorneoModel entity = new ListaTorneoModel();
  TourmentService entityService;
  ImageService entityImage = new ImageService();
  TourmentService entityGet = TourmentService();

  ResultadoModel entityResultado = new ResultadoModel();
  ResultadoService entityResultadoService = new ResultadoService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar('TORNEOS VIRTUAL MATCH'),
        body: SingleChildScrollView(child: bodyContainer(context)),
        drawer: DrawerMenu(),
        bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          showInformationBasic(
            context,
            'REGISTRA EL RESULTADO DEL GANADOR ',
            'Cargar la imagen del resultado final del encuentro.',
          ),
          sizedBox(0, 8),
          Container(
            width: size.width * 0.94,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            decoration: containerFileds(),
            child: _fields(context),
          ),
          copyRigthBlack(),
          //futureBuilderTorneo(context),
        ],
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0, 8),
        registerPhoto(widget.entity, widget.idTorneo),
        Text("Click en la imagen para subir la foto del resultado"),
        dividerBlack(),
        registerScored(widget.entity, widget.idTorneo),
        sizedBox(0, 10),
        botonRegistrarScored(widget.entity, widget.idTorneo),
      ],
    );
  }

  Widget botonRegistrarScored(PartidosPorTorneoModel entity, int idTorneo) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: 30),
      text: "Registrar",
      textStyle: TextStyle(fontSize: 18),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeDefault,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: () {
        if (entity.idEliminatoria == 0) {
          //  es para ligaº
          entityResultado.states = StateEntity.Update;
          entityResultado.idResultado = entity.idResultado;
          if (entityResultado.gol1 == entityResultado.gol2) {
            showSnackbar("No pueden empatar!", scaffoldKey);
          } else
            _submitLiga();
        } else {
          // es para eliminatoria
          entityResultado.states = StateEntity.Update;
          entityResultado.idResultado = entity.idResultado;
          if (entityResultado.gol1 == entityResultado.gol2) {
            showSnackbar("No pueden empatar!", scaffoldKey);
          } else
            _submit();
        }
      },

      //blockButton: true,
    );
  }

  _submit() async {
    executeCUD(entityResultadoService, entityResultado);
  }

  _submitLiga() async {
    executeCUDLiga(entityResultadoService, entityResultado);
  }

  void executeCUD(ResultadoService entityService, ResultadoModel entity) async {
    try {
      await entityService.update(entity, entity.idResultado).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);
          navegation(context, TourmentPage(idTorneo: widget.idTorneo));
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      print('EL RESULTTTTT: ${error.toString()} ');
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  void executeCUDLiga(
      ResultadoService entityService, ResultadoModel entity) async {
    try {
      await entityService.updateLiga(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);
          navegation(context, TourmentPage(idTorneo: widget.idTorneo));
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      print('EL RESULTTTTT: ${error.toString()} ');
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }

  Widget futureBuilderTorneo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    sizedBox(0, 10);
    return FutureBuilder(
        future: entityGet.getId(new ListaTorneoModel(), widget.idTorneo),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              ListaTorneoModel entity = snapshot.data[0];
              return Center(
                child: Column(
                  children: <Widget>[
                    sizedBox(0, 7),
                    Container(
                      width: size.width * 0.95,
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      decoration: boxDecoration(),
                      child: Column(
                        children: <Widget>[
                          gfListTile(
                            Text('TORNEO: ${entity.nombreTorneo.toUpperCase()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Text('DETALLE: ${entity.detalle}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Text(
                                'FECHA: ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            null,
                            avatarCircle(entity.foto, 45.0),
                            EdgeInsets.all(3),
                            EdgeInsets.all(3),
                          ),
                        ],
                      ),
                    ),
                    //   Text('Estado'),
                  ],
                ),
              );
          }
        });
  }

  Widget registerScored(PartidosPorTorneoModel entity, int idTorneo) {
    final size = MediaQuery.of(context).size;
    sizedBox(0, 6);
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      //decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          sizedBox(0, 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      avatarCircle(entity.iFoto, 35.0),
                      Text(entity.iJugador),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 2,
                        style: TextStyle(color: Colors.black, fontSize: 30),
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(fontSize: 30, color: Colors.black),
                          hintText: '0',
                          hintStyle:
                              TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        onChanged: (value) {
                          entityResultado.gol1 = int.parse(value);
                        },
                      )
                    ],
                  ),
                ),
              ),
              sizedBox(15, 0),
              Container(
                  child: Text(
                "VS",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              )),
              sizedBox(15, 0),
              Flexible(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      avatarCircle(entity.dFoto, 35.0),
                      Text(entity.dJugador),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 2,
                        style: TextStyle(color: Colors.black, fontSize: 30),
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(fontSize: 30, color: Colors.black),
                          hintText: '0',
                          hintStyle:
                              TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        onChanged: (value) {
                          entityResultado.gol2 = int.parse(value);
                        },
                      )
                    ],
                  ),
                ),
              ),
              sizedBox(0, 6),
            ],
          ),
        ],
      ),
    );
  }

  Widget subirFoto(File file, String picture, double heigth) {
    if (picture != null) {
      return InkWell(
        onTap: () => _seleccionarFoto(),
        child: FadeInImage(
          image: NetworkImage(picture),
          placeholder: AssetImage('assets/jar-loading.gif'),
          height: heigth,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return InkWell(
        onTap: () => _seleccionarFoto(),
        child: Image(
          image: AssetImage(file?.path ?? IMAGE_LOGO),
          height: heigth,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget registerPhoto(PartidosPorTorneoModel entity, int idTorneo) {
    return Column(
      children: <Widget>[
        subirFoto(photo, image, 90.0),
      ],
    );
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _procesarImagen(ImageSource origen) async {
    final photo = await ImagePicker().getImage(source: origen);
    if (photo != null) {
      image = await entityImage.uploadImage(photo.path);
      setState(() {
        entityResultado.foto = image;
      });
    }
  }
}
