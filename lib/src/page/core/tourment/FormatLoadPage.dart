import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

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
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/FormatService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/service/crudService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/FormatoModel.dart';

class FormatLoadPage extends StatefulWidget {
  static final String routeName = 'formatLoad';
  String idTorneo;

  String nombreTorneo;

  FormatLoadPage(
      {Key key, @required this.idTorneo, @required this.nombreTorneo})
      : super(key: key);

  @override
  _FormatLoadPageState createState() => _FormatLoadPageState();
}

class _FormatLoadPageState extends State<FormatLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // final controllerName = TextEditingController();
  // final controllerDetail = TextEditingController();
  // final controllerHastag = TextEditingController();
  // final controllerGift = TextEditingController();
  // final controllerOrganization = TextEditingController();
  // final controllerCount = TextEditingController();
  // final controllerFaseTime = TextEditingController();

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFieldTimeController = new TextEditingController();

//DEFINICION DE BLOC Y MODEL
  CrudService entityService;
  FormatoModel entity = new FormatoModel();
  ImageService entityImage = new ImageService();
  ClasificadorService entityGet = ClasificadorService();

  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  bool isFree = false;
  bool isManual = false;
  File photo;
  int typeTourment = 14;
  int typeInscription = 14;
  int typeMaterial = 14;
  int typeAsigment = 14;
  String typeCount = '2';
  TimeOfDay _time = TimeOfDay.now();
  String _fecha = DateTime.now().toString().substring(0, 10);
  String image = IMAGE_DEFAULT;

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
    //entityService = <CrudService>(context);

    final FormatoModel entityModel = ModalRoute.of(context).settings.arguments;

    if (entityModel != null) {
      entity = entityModel;
      entity.states = StateEntity.Update;
    }

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          showPictureOval(photo, image, 130.0),
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
            sizedBox(0.0, 125.0),
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
        sizedBox(0.0, 7.0),
        _comboTorneoCreado(_opcionTipoCompeticion),
        _comboJugador(),
        _comboCompeticion(_opcionTipoCompeticion),
        _comboTorneo(_opcionTipoTorneo),
        _comboModalidad(_opcionTipoModalidad),
        _porEquipo('Por equipo?'),
        _inscription('Torneo de Pago'),
        _selection('Selección Manual'),
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

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 4),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("yyyy-MM-dd").format(picked);
        _inputFieldDateController.text = _fecha;
        //print(_inputFieldDateController.text);
      });
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,

      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
      //    locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _time = picked;
        _inputFieldTimeController.text = _time.hour.toString() +
            ':' +
            _time.minute
                .toString(); //TimeOfDay(hour: _time.hour, minute: _time.minute).toString();
      });
    }
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

  Widget _comboTorneoCreado(String _opcionTipoCompeticion) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 26),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text('Selecciones el torneo:'),
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
      value: isFree,
      title: Text(text),
      subtitle: Text('Habilitar opción si será de pago.'),
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
//
    entity.idTorneo = 8;
    entity.idTipoCompeticion = 8;
    entity.idaTipoTorneo = 8;
    entity.idaInscripcion = 8;
    entity.idaAsignacion = 8;
    entity.cantidadJugadores = 8;
    entity.idaTipoModalidad = 8;
    entity.usuarioAuditoria = prefs.email;
  }

  void executeCUD(CrudService entityService, FormatoModel entity) async {
    try {
      await entityService.repository(entity, '').then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');
        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);

          // Navigator.push(
          //     context,
          //     PageTransition(
          //         curve: Curves.bounceOut,
          //         type: PageTransitionType.rotate,
          //         alignment: Alignment.topCenter,
          //         child: FormatLoadPage(idTorneo: '8')));
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
    //  navegation(context, FormatLoadPage());
  }
}
