import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentListPage.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';

class TourmentAllPage extends StatefulWidget {
  static final String routeName = 'tourment';
  const TourmentAllPage({Key key}) : super(key: key);

  @override
  _TourmentAllPageState createState() => _TourmentAllPageState();
}

class _TourmentAllPageState extends State<TourmentAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [TourmentLoadPage(), TourmentListPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = TourmentAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => new TourmentService()),
      ],
      child: Scaffold(
        appBar: appBar('CREACIÓN DEL TORNEO'),
        drawer: DrawerMenu(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 21.0,
          backgroundColor: AppTheme.themeDefault,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.newspaper,
                  size: 25,
                ),
                title: Text('Noticias')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.paperPlane,
                  size: 25,
                ),
                title: Text('Listado Noticias')),
          ],
          currentIndex: page,
          unselectedItemColor: Colors.purple,
          selectedItemColor: AppTheme.themeWhite,
          onTap: _onItemTapped,
        ),
        body: optionPage[page],
      ),
    );
  }
}

class TourmentLoadPage extends StatefulWidget {
  static final String routeName = 'tourmnetLoad';

  @override
  _TourmentLoadPageState createState() => _TourmentLoadPageState();
}

class _TourmentLoadPageState extends State<TourmentLoadPage> {
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
  TextEditingController _inputFieldDateEndController =
      new TextEditingController();
  TextEditingController _inputFieldTimeEndController =
      new TextEditingController();

//DEFINICION DE BLOC Y MODEL
  TourmentService entityService;
  TorneoModel entity = new TorneoModel();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  bool isFree = false;
  File photo;
  int typeTourment = 14;
  int typeInscription = 14;
  int typeMaterial = 14;
  int typeAsigment = 14;
  String typeCount = '2';
  TimeOfDay _time = TimeOfDay.now();
  String _fecha = DateTime.now().toString().substring(0, 10);
  TimeOfDay _timeEnd = TimeOfDay.now();
  String _fechaEnd = DateTime.now().toString().substring(0, 10);
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
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
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

        _inscription('Torneo Grautuito'),
        _combo(),
        _text(
            controllerName,
            entity.nombre,
            'NOMBRE DEL TORNEO'.toUpperCase(),
            100,
            2,
            'Ingrese nombre al torneo',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerDetail,
            entity.detalle,
            'Detalle del torneo',
            250,
            2,
            'Ingrese Detalle del torneo',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: Colors.black26),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerHastag,
            entity.hastag,
            'HASTAG'.toUpperCase(),
            100,
            2,
            'Ingrese Hastag',
            true,
            FaIcon(FontAwesomeIcons.userFriends, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerGift,
            entity.premios,
            'PREMIOS'.toUpperCase(),
            160,
            2,
            'Ingrese el tipo de premios',
            true,
            FaIcon(FontAwesomeIcons.mapMarked, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerOrganization,
            entity.organizador,
            'ORGANIZADORES'.toUpperCase(),
            160,
            2,
            'Ingrese los organizadores',
            true,
            FaIcon(FontAwesomeIcons.mapMarked, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _dateInit('Fecha de inicio'),
        _hourInit('Hora de inicio'),
        _dateEnd('Fecha Fin'),
        _hourEnd('Hora de conclusión'),
        //  _comboBox('Tipo.', myController.text),
        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),

        _button('Guardar', 18.0, 20.0),
      ],
    );
  }

  Widget _combo() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Cantidad:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: typeCount,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeDefault),
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
      activeColor: AppTheme.themeDefault,
      onChanged: (value) => setState(() {
        isFree = value;
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

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 4),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
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

  Widget _dateInit(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: text,
            labelText: text,
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Widget _hourInit(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldTimeController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: text,
            labelText: text,
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectTime(context);
        },
      ),
    );
  }

  _selectDateEnd(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 4),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fechaEnd = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateEndController.text = _fechaEnd;
        //print(_inputFieldDateController.text);
      });
    }
  }

  _selectTimeEnd(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _timeEnd,

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
        _timeEnd = picked;
        _inputFieldTimeEndController.text = _timeEnd.hour.toString() +
            ':' +
            _timeEnd.minute
                .toString(); //TimeOfDay(hour: _time.hour, minute: _time.minute).toString();
      });
    }
  }

  Widget _dateEnd(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateEndController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: text,
            labelText: text,
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateEnd(context);
        },
      ),
    );
  }

  Widget _hourEnd(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldTimeEndController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: text,
            labelText: text,
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.clock, color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectTimeEnd(context);
        },
      ),
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
    // entity.nombre = controllerNoticia.text;
    // entity.detalle = controllerDetalle.text;
    entity.foto = IMAGE_LOGO;
    entity.usuarioAuditoria = prefs.email;
    entity.fechaAuditoria = '2020-08-10 08:25';

    entity.idTorneo = 0;
    entity.idOrganizacion = int.parse(prefs.idInstitution);
    entity.idaTipoTorneo = 23;
    entity.idaInscripcion = 39;
    entity.nombre = controllerName.text;
    entity.detalle = controllerDetail.text;
    entity.hastag = controllerHastag.text;
    entity.premios = controllerGift.text;
    entity.organizador = controllerOrganization.text;
    entity.foto = IMAGE_LOGO;
    entity.fechaInicio =
        _inputFieldDateController.text + ' ' + TimeOfDay.now().toString();
    entity.fechaFin = _inputFieldDateEndController.text+ ' ' + TimeOfDay.now().toString();
    entity.horaInicio = _inputFieldTimeController.text;
    entity.horaFin = _inputFieldTimeEndController.text;
    entity.idaAsignacion = -1;
    entity.cantidadJugadores = int.parse(typeCount);
    entity.horasFase = 2;
    entity.idaTipoModalidad = -1;
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
