import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_loader_type.dart';
//import 'package:provider/provider.dart';
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
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/model/entity/EntityMap/FormatoModel.dart';
import 'package:virtual_match/src/widget/image/ImageWidget.dart';

class MiniFormatLoadPage extends StatefulWidget {
  static final String routeName = 'formatLoad';

  MiniFormatLoadPage({
    Key key,
  }) : super(key: key);

  @override
  _MiniFormatLoadPageState createState() => _MiniFormatLoadPageState();
}

class _MiniFormatLoadPageState extends State<MiniFormatLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

//DEFINICION DE BLOC Y MODEL
  TourmentService entityService = new TourmentService();
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
  File photo;
  String typeCount = '2';
  String image = IMAGE_DEFAULT;
  String _opcionTipoCompeticion = '27';
  String _opcionTipoTorneo = '23';
  String _opcionTipoModalidad = '44';
  String _opcionCodTorneo = '0';

  List<String> _cantidad = ['2', '3', '4', '5', '6', '7', '8'];

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
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          //  showPictureOval(photo, image, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
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
              //  color: Colors.black87,
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
        //  sizedBox(0.0, 7.0),
        showPictureOval(photo, image, 125.0),
        dividerBlack(),
        Row(
          children: [
            sizedBox(30.0, 0.0),
            Text('Selecciona tu torneo creado'),
          ],
        ),
        _comboCodTroneo(_opcionCodTorneo),
        _comboTorneoCreado(_opcionTipoCompeticion),
        _comboJugador(),
        _comboModalidad(_opcionTipoModalidad),
        _comboTorneo(_opcionTipoTorneo),
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
        keyboardType: TextInputType.text,
        // controller: controller,
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

  Widget _comboCodTroneo(String _opcionCodTorneos) {
    print("prefsss:${prefs.idPlayer}");

    return Center(
        child: FutureBuilder(
            future: entityGet1.getId(
                new ListaTorneoModel(), int.parse(prefs.idPlayer)),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 30.0),
                    //  Text('Selecciones el torneo:'),

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

  Widget _comboJugador() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Cantidad Jugadores:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: typeCount,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themePurple),
          items: _count(),
          onChanged: (opt) {
            setState(() {
              typeCount = opt;
            });
          },
        ),
      ],
    );
  }

  Widget _comboTorneoCreado(String _opcionTipoCompeticions) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 26),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo de torneo:'),
                    SizedBox(width: 15.0),
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

  Widget _comboCompeticion(String _opcionTipoCompeticions) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 26),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo Competición:'),
                    SizedBox(width: 15.0),
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

  Widget _comboTorneo(String _opcionTipoTorneowww) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 22),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo Torneo:'),
                    SizedBox(width: 15.0),
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

  List<DropdownMenuItem<String>> _count() {
    List<DropdownMenuItem<String>> lista = new List();

    _cantidad.forEach((cantidad) {
      lista.add(DropdownMenuItem(
        child: Text(cantidad),
        value: cantidad,
      ));
    });
    return lista;
  }

  Widget _porEquipo(String text) {
    return SwitchListTile(
      value: isFree,
      title: Text(text),
      subtitle: Text(
          'Habilitar opción si será equipo, caso contrario sera individual'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        isFree = value;
      }),
    );
  }

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
      subtitle: Text('Habilitar opción si será manual.'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        isManual = value;
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
    executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idTorneo = 68;
    entity.idTipoCompeticion = int.parse(_opcionTipoCompeticion);
    entity.idaTipoTorneo = int.parse(_opcionTipoTorneo);
    entity.idaInscripcion = 1;
    entity.idaAsignacion = 1;
    entity.cantidadJugadores = int.parse(typeCount);
    entity.idaTipoModalidad = int.parse(_opcionTipoCompeticion);
    entity.usuarioAuditoria = prefs.email;
  }

  void executeCUD(TourmentService entityService, FormatoModel entity) async {
    try {
      await entityService.repositoryDetail(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);

          navegation(context, TourmentListPage());
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
    //  navegation(context, FormatLoadPage());
  }
}
