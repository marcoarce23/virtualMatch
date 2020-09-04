import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/tourment/FormatLoadPage.dart';
import 'package:virtual_match/src/page/core/tourment/TourmentListPage.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/service/crudService.dart';
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
  final List<Widget> optionPage = [
    TourmentLoadPage(),
    FormatLoadPage(),
    TourmentListPage()
  ];

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
        ChangeNotifierProvider(builder: (_) => new CrudService()),
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

//DEFINICION DE BLOC Y MODEL
  CrudService entityService;
  TorneoModel entity = new TorneoModel();
  ImageService entityImage = new ImageService();
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
  String image = IMAGE_DEFAULT;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    entityService = Provider.of<CrudService>(context);

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
            sizedBox(0.0, 8.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
              //  color: Colors.black87,
              width: size.width * 0.94,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  text('CARGA IMAGEN DEL TORNEO ', AppTheme.themeDefault, 1,
                      15.0),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                ],
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

  _crearIconAppImagenes() {
    return IconButton(
      icon: Icon(
        Icons.photo_size_select_actual,
        color: AppTheme.themePurple,
      ),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: Icon(
        Icons.camera_alt,
        color: AppTheme.themePurple,
      ),
      onPressed: _tomarFoto,
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
          showPictureOval(photo, image, 125.0),
          dividerBlack(),
        _text(
            controllerName,
            entity.nombre,
            'Nombre del torneo',
            100,
            1,
            'Ingrese nombre al torneo',
            true,
            FaIcon(FontAwesomeIcons.futbol, color: AppTheme.themeDefault),
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
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerHastag,
            entity.hastag,
            '#Hastag Virtual Match',
            100,
            1,
            'Ingrese #Hastag',
            true,
            FaIcon(FontAwesomeIcons.hashtag, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerGift,
            entity.premios,
            'Premios en Bs.',
            5,
            1,
            'Ingrese el monto el premio en Bs.',
            true,
            FaIcon(FontAwesomeIcons.moneyCheck, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerOrganization,
            entity.organizador,
            'Inscripción en Bs.',
            5,
            1,
            'Ingrese el monto de la Inscripción',
            true,
            FaIcon(FontAwesomeIcons.moneyBillAlt, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _dateInit('Fecha de inicio'),
        _hourInit('Hora de inicio'),
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

    print('myControllerSOY EL VALOR DE ' + controllerDetail.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idTorneo = 0;
    entity.idOrganizacion = int.parse(prefs.idInstitution);
    entity.nombre = controllerName.text;
    entity.detalle = controllerDetail.text;
    entity.hastag = controllerHastag.text;
    entity.premios = controllerGift.text;
    entity.organizador = controllerOrganization.text;
    //  entity.foto = IMAGE_LOGO;
    entity.fechaInicio = _inputFieldDateController.text + ' ' + '12:00';
    entity.horaInicio = _inputFieldTimeController.text;
    entity.usuarioAuditoria = prefs.email;
  }

  void executeCUD(CrudService entityService, TorneoModel entity) async {
    try {
      await entityService
          .repository(entity, API + '/api/Torneo')
          .then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

        if (result["tipo_mensaje"] == '0') {
          showSnackbar(STATUS_OK, scaffoldKey);

          // navigation(
          //   context, TourmentListPage()
          // );
          
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
    //  navegation(context, FormatLoadPage());
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final photo = await ImagePicker().getImage(source: origen);
    if (photo != null) {
      image = await entityImage.uploadImage(photo.path);
      print('imagennnnn $image');
      setState(() {
        entity.foto = image;

        print('cargadod e iagen ${entity.foto}');
      });
    }
  }
}
