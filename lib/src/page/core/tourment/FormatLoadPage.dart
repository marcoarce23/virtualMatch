import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentListPage.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/ClasificadorService.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/model/entity/EntityMap/FormatoModel.dart';

class FormatLoadPage extends StatefulWidget {
  static final String routeName = 'formatLoad';

  FormatLoadPage({
    Key key,
  }) : super(key: key);

  @override
  _FormatLoadPageState createState() => _FormatLoadPageState();
}

class _FormatLoadPageState extends State<FormatLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerCantidad = TextEditingController();
  final controllerGrupos = TextEditingController();

//DEFINICION DE BLOC Y MODEL
  FormatoModel entity = new FormatoModel();
  ImageService entityImage = new ImageService();
  ClasificadorService entityGet = ClasificadorService();
  TourmentService entityGet1 = TourmentService();

  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  bool isFree = false;
  bool isManual = false;
  bool isIndividual = false;
  bool is11vs11 = false;
  int int11vs11 = 0;
  File photo;
  String typeCount = '2';
  String image = IMAGE_DEFAULT;
  String _opcionTipoCompeticion = '27';
  String _opcionTipoTorneo = '23';
  String _opcionTipoModalidad = '44';
  String _opcionCodTorneo = '0';

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CREACIÓN DEL TORNEO'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            sizedBox(0.0, 15.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
              width: size.width * 0.94,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
            sizedBox(0.0, 8.0),
            Container(
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerFileds(),
              child: _fields(context),
            ),
            copyRigthBlack(),
          ],
        ),
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0.0, 8.0),
        _comboCodTroneo(_opcionCodTorneo),
        _text(
            controllerGrupos,
            '0',
            '(*) Ingrese cantidad de Jugadores/Equipos',
            3,
            1,
            'Ingrese la cantidad de Jugadores/Equipos',
            true,
            null, // FaIcon(FontAwesomeIcons.futbol, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            AppTheme.themePurple),
        _text(
            controllerCantidad,
            '0',
            '(*) Ingrese cantidad de Jugadores/Equipos por grupos',
            3,
            1,
            'Ingrese cantidad de jugadores/equipos por grupos',
            true,
            null, // FaIcon(FontAwesomeIcons.futbol, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            AppTheme.themePurple),
        _comboCompeticion(_opcionTipoCompeticion),
        _comboTorneo(_opcionTipoTorneo),
        _comboModalidad(_opcionTipoModalidad),
        //     _porEquipo('Por equipo?'),
        _inscription('Torneo de Pago'),
        _selection('Creación con boots'),
        _vs11vs('Será Torneo 11 Vs. 11'),
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        _button('Guardar', 18.0, 20.0),
      ],
    );
  }

  Widget _text(
      TextEditingController controller,
      String initialValue,
      String labelText,
      int maxLength,
      int maxLines,
      String hintText,
      bool isValidate,
      FaIcon icon,
      Color hoverColor,
      Color fillColor,
      Color focusColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: initialValue,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: true,
        maxLength: maxLength,
        maxLines: maxLines,
        autocorrect: true,
        autovalidate: false,
        cursorColor: AppTheme.themeDefault,
        toolbarOptions:
            ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
        decoration: inputDecoration(
            hintText, labelText, icon, hoverColor, fillColor, focusColor),
        onChanged: (value) {
          setState(() {
            controller.text = value;
          });
        },
        validator: (value) =>
            validator.validateTextfieldEmpty(value, isValidate),
        onSaved: (value) => controller.text = value,
      ),
    );
  }

  Widget _comboCodTroneo(String _opcionCodTorneosss) {
    return Center(
        child: FutureBuilder(
            future: entityGet1.get1(new ListaTorneoModel(), int.parse('1')),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    // Text('Selecciones el torneo:'),
                    sizedBox(10.0, 0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themePurple),
                      value: _opcionCodTorneo,
                      items: getDropDownTorneo(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionCodTorneo = value;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return GFLoader(type: GFLoaderType.circle, size: 35.0);
              }
            }));
  }

  // Widget _comboTorneoCreado(String _opcionTipoCompeticionss) {
  //   return Center(
  //       child: FutureBuilder(
  //           future: entityGet.get(new ClasificadorModel(), 26),
  //           builder: (context, AsyncSnapshot snapshot) {
  //             if (snapshot.hasData) {
  //               return Row(
  //                 children: <Widget>[
  //                   sizedBox(15.0, 0),
  //                   Text('Selecciones el torneo:'),
  //                   sizedBox(15.0, 0),
  //                   DropdownButton(
  //                     icon: FaIcon(FontAwesomeIcons.sort,
  //                         color: AppTheme.themePurple),
  //                     value: _opcionTipoCompeticion,
  //                     items: getDropDown(snapshot),
  //                     onChanged: (value) {
  //                       setState(() {
  //                         _opcionTipoCompeticion = value;
  //                         print('ddddd: $_opcionTipoCompeticion');
  //                       });
  //                     },
  //                   ),
  //                 ],
  //               );
  //             } else {
  //               return GFLoader(type: GFLoaderType.circle, size: 35.0);
  //             }
  //           }));
  // }

  Widget _comboCompeticion(String _opcionTipoCompeticionss) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 26),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    sizedBox(15.0, 0),
                    Text('Tipo Competición:'),
                    sizedBox(15.0, 0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themePurple),
                      value: _opcionTipoCompeticion,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionTipoCompeticion = value;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return GFLoader(type: GFLoaderType.circle, size: 35.0);
              }
            }));
  }

  Widget _comboTorneo(String _opcionTipoTorneosss) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 22),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    sizedBox(15.0, 0),
                    Text('Tipo Torneo:'),
                    sizedBox(15.0, 0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themePurple),
                      value: _opcionTipoTorneo,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionTipoTorneo = value;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return GFLoader(type: GFLoaderType.circle, size: 35.0);
              }
            }));
  }

  Widget _comboModalidad(String _opcionTipoModalidadss) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 42),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    sizedBox(15.0, 0),
                    Text('Tipo Moldalidad'),
                    sizedBox(15.0, 0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themePurple),
                      value: _opcionTipoModalidad,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionTipoModalidad = value;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return GFLoader(type: GFLoaderType.circle, size: 35.0);
              }
            }));
  }

  List<DropdownMenuItem<String>> getDropDownTorneo(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      ListaTorneoModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombreTorneo),
        value: item.idTorneo.toString(),
      ));
    }
    return lista;
  }

  List<DropdownMenuItem<String>> getDropDown(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      ClasificadorModel item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.idClasificador.toString(),
      ));
    }
    return lista;
  }

  // Widget _porEquipo(String text) {
  //   return SwitchListTile(
  //     value: isFree,
  //     title: Text(text),
  //     subtitle: Text(
  //         'Habilitar opción si será equipo, caso contrario sera individual'),
  //     activeColor: AppTheme.themePurple,
  //     onChanged: (value) => setState(() {
  //       isFree = value;
  //     }),
  //   );
  // }

  Widget _inscription(String text) {
    return SwitchListTile(
      value: isIndividual,
      title: Text(text),
      subtitle: Text('Habilitar opción si será de pago.'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        isIndividual = value;
      }),
    );
  }

  Widget _selection(String text) {
    return SwitchListTile(
      value: isManual,
      title: Text(text),
      subtitle: Text('Habilitar opción si se crearán boots'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        isManual = value;
      }),
    );
  }

  Widget _vs11vs(String text) {
    return SwitchListTile(
      value: is11vs11,
      title: Text(text),
      subtitle: Text('Habilitar opción si será 11 Vs. 11.'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        is11vs11 = value;
      }),
    );
  }

  Widget _button(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeDefault,
      icon: FaIcon(FontAwesomeIcons.checkCircle, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submit,
    );
  }

  _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    //print('myControllerSOY EL VALOR DE ' + controllerDetail.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityGet1, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    int intFree = 0;
    int intManual = 0;

    if (isFree) intFree = 1;
    if (isManual) intManual = 1;
    if (is11vs11) int11vs11 = 1;

    entity.idTorneo = int.parse(_opcionCodTorneo);
    entity.idTipoCompeticion = int.parse(_opcionTipoCompeticion);
    entity.idaTipoTorneo = int.parse(_opcionTipoTorneo);
    entity.idaInscripcion = intFree;
    entity.idaAsignacion = int.parse(controllerCantidad.text);
    entity.cantidadJugadores = int.parse(controllerGrupos.text);
    entity.idaTipoModalidad = int.parse(_opcionTipoModalidad);
    entity.usuarioAuditoria = prefs.email;
    entity.conBoot = intManual;
    entity.con11vs11 = int11vs11;
  }

  void executeCUD(TourmentService entityService, FormatoModel entity) async {
    int cantidadGrupos = int.parse(controllerGrupos.text);
    int cantidads = (int.parse(controllerCantidad.text) == 0)
        ? 1
        : int.parse(controllerCantidad.text);

    setState(() {
      _opcionCodTorneo = '0';
    });

    try {
      if (entity.conBoot == 1 && entity.idTipoCompeticion == 28) {
        await entityService.repositoryDetail(entity).then((result) async {
          await entityService
              .ejecutarTorneoManual(
            entity,
            int.parse(controllerCantidad.text),
            (cantidadGrupos ~/ cantidads),
          )
              .then((result) {
            print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
            if (result["tipo_mensaje"] == '0') {
              showSnackbar(result["mensaje"], scaffoldKey);

              navegation(context, TourmentListPage());
            } else
              showSnackbar(result["mensaje"], scaffoldKey);
            navegation(context, TourmentListPage());
          });
        });
      } else {
        entity.conBoot = 0;
        await entityService.repositoryDetail(entity).then((result) async {
          print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
          if (result["tipo_mensaje"] == '0') {
            showSnackbar(result["mensaje"], scaffoldKey);

            navegation(context, TourmentListPage());
          } else
            showSnackbar(result["mensaje"], scaffoldKey);
        });
      }
    } catch (error) {
      showSnackbar(STATUS_ERROR+ ' ${error.toString()} ', scaffoldKey);
    }
    //  navegation(context, FormatLoadPage());
  }
}
