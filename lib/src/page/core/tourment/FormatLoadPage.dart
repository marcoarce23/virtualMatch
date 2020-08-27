import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_loader_type.dart';

import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/ClasificadorService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';

class FormatLoadPage extends StatefulWidget {
  static final String routeName = 'formatLoad';

  @override
  _FormatLoadPageState createState() => _FormatLoadPageState();
}

class _FormatLoadPageState extends State<FormatLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerName = TextEditingController();
  final controllerDetail = TextEditingController();
  final controllerHastag = TextEditingController();
  final controllerGift = TextEditingController();
  final controllerOrganization = TextEditingController();
  final controllerCount = TextEditingController();
  final controllerFaseTime = TextEditingController();

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFieldTimeController = new TextEditingController();

//DEFINICION DE BLOC Y MODEL
  TourmentService entityService;
  TorneoModel entity = new TorneoModel();
  ClasificadorService entityGet = ClasificadorService();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = true;
  bool isFree = true;
  bool isManual = true;
  File photo;
  int typeTourment = 14;
  int typeInscription = 14;
  int typeMaterial = 14;
  int typeAsigment = 14;
  String typeCount = '2';
  String _opcionTipoCompeticion = '27';
  String _opcionTipoTorneo = '23';
  String _opcionTipoModalidad = '43';

  List<String> _cantidad = [
    '2',
    '4',
    '8',
    '16',
    '32',
    '64',
    '128',
    '256',
    '512'
  ];

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    entityService = Provider.of<TourmentService>(context);

    final TorneoModel entityModel = ModalRoute.of(context).settings.arguments;

    if (entityModel != null) {
      entity = entityModel;
      entity.states = StateEntity.Update;
    }

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          showPictureOval(photo, IMAGE_DEFAULT, 130.0),
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
            sizedBox(0.0, 130.0),
            Container(
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerFileds(),
              child: _fields(context),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0.0, 7.0),
        _inscription('Torneo de Pago'),
        _selection('Selección Manual'),
        _comboJugador(),
        _comboCompeticion(_opcionTipoCompeticion),
        _comboTorneo(_opcionTipoTorneo),
        _comboModalidad(_opcionTipoModalidad),
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),
        _button('Crear torneo', 18.0, 30.0),
      ],
    );
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

  Widget _comboCompeticion(String _opcionTipoCompeticion) {
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

  Widget _comboTorneo(String _opcionTipoTorneo) {
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

  Widget _comboModalidad(String _opcionTipoModalidad) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 42),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Tipo Moldalidad'),
                    SizedBox(width: 15.0),
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

  Widget _inscription(String text) {
    return SwitchListTile(
      value: isFree,
      title: Text(text),
      // subtitle: Text('Habilitar opción si será voluntario.'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        isFree = value;
      }),
    );
  }

  Widget _selection(String text) {
    return SwitchListTile(
      value: isManual,
      title: Text(text),
      // subtitle: Text('Habilitar opción si será voluntario.'),
      activeColor: AppTheme.themePurple,
      onChanged: (value) => setState(() {
        isManual = value;
      }),
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

  Widget _button(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: Colors.black,
      icon: FaIcon(FontAwesomeIcons.playstation, color: AppTheme.themeWhite),
      shape: GFButtonShape.pills,
      onPressed: (_save) ? null : _submit,
    );
  }

  _submit() async {
    //var _result;

    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    print('myControllerSOY EL VALOR DE ' + controllerDetail.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idTorneo = 0;
    entity.idOrganizacion = 133;
    entity.usuarioAuditoria = prefs.email;
    entity.fechaAuditoria = '2020-08-10 08:25';
    entity.idTorneo = 0;
    entity.idOrganizacion = int.parse(prefs.idInstitution);
    entity.nombre = controllerName.text;
    entity.detalle = controllerDetail.text;
    entity.hastag = controllerHastag.text;
    entity.premios = controllerGift.text;
    entity.organizador = controllerOrganization.text;
    entity.foto = IMAGE_LOGO;
    entity.fechaInicio =
        _inputFieldDateController.text + ' ' + TimeOfDay.now().toString();
    entity.horaInicio = _inputFieldTimeController.text;
    entity.usuarioAuditoria = prefs.email;
  }

  void executeCUD(TourmentService entityService, TorneoModel entity) async {
    try {
      await entityService.repository(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0')
          showSnackbar(STATUS_OK, scaffoldKey);
        else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
}
