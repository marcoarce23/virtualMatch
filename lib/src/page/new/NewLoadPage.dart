import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/page/new/NewListPage.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart'
    as gets;

class NewAllPage extends StatefulWidget {
  static final String routeName = 'new';
  const NewAllPage({Key key}) : super(key: key);

  @override
  _NewAllPagePageState createState() => _NewAllPagePageState();
}

class _NewAllPagePageState extends State<NewAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [NewLoadPage(), NewListPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = NewAllPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeDefault,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/image/noticias_eventos.png',
                width: 28,
                height: 28,
              ),
              title: Text('Nueva')),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/image/noticias.png',
                width: 28,
                height: 28,
              ),
              title: Text('Noticias')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeWhite,
        selectedItemColor: AppTheme.themePurple,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
      //  ),
    );
  }
}

class NewLoadPage extends StatefulWidget {
  static final String routeName = 'newLoad';

  @override
  _NewLoadPageState createState() => _NewLoadPageState();
}

class _NewLoadPageState extends State<NewLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerNoticia = TextEditingController();
  final controllerDetalle = TextEditingController();
  final controllerDirigidoA = TextEditingController();
  final controllerUbicacion = TextEditingController();

//DEFINICION DE BLOC Y MODEL
  NewService entityService = new NewService();
  NoticiaEventoModel entity = new NoticiaEventoModel();
  gets.NoticiaEventoModel entityGet = new gets.NoticiaEventoModel();
  ImageService entityImage = new ImageService();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFieldTimeController = new TextEditingController();

  bool _save = false;
  File photo;
  String _fecha = DateTime.now().toString().substring(0, 10);
  TimeOfDay _time = TimeOfDay.now();
  int _group = 1;
  // ignore: unused_field
  int _selectedRadio = 1;
  String image = IMAGE_DEFAULT;
  int unaVez = 0;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entity.states = StateEntity.Insert;
    entity.foto = image;

    final gets.NoticiaEventoModel entityModelGet =
        ModalRoute.of(context).settings.arguments;

    if (entityModelGet != null) {
      entity.states = StateEntity.Update;

      if (unaVez == 0) {
        entity.idNoticiaEvento = entityModelGet.idNoticiaEvento;
        entity.objetivo = entityModelGet.objetivo;
        entity.titulo = entityModelGet.titulo;
        entity.dirigidoA = entityModelGet.dirigidoa;
        entity.ubicacionUrl = entityModelGet.ubicacionUrl;
        _inputFieldDateController.text = entityModelGet.fecha;
        _inputFieldTimeController.text = entityModelGet.hora;
        entity.foto = entityModelGet.foto;
        _selectedRadio = entityModelGet.tipo;

        entity.foto = entityModelGet.foto;
        image = entityModelGet.foto;
      }

      print('ddd ${entity.foto}');
    }
    unaVez = 1;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CREA NOTICIAS-EVENTOS'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, entity.foto),
          showPictureOval(photo, entity.foto, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
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
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  text('CARGA LAS NOTICIAS Y EVENTOS', AppTheme.themeDefault, 1,
                      15.0),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                ],
              ),
            ),
            sizedBox(0.0, 10.0),
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
        sizedBox(0.0, 7.0),
        showPictureOval(photo, image, 70.0),
        dividerBlack(),

        Row(
          children: <Widget>[
            SizedBox(width: 1),
            sizedBox(15.0, 0.0),
            Text('Noticia'),
            Radio(
              value: 0,
              groupValue: _group,
              onChanged: (T) {
                _selectedRadio = T;
                setState(() {
                  _group = T;
                });
              },
            ),
            Text('Evento'),
            Radio(
              value: 1,
              groupValue: _group,
              onChanged: (T) {
                _selectedRadio = T;
                setState(() {
                  _group = T;
                });
              },
            ),
          ],
        ),

        _text(
            controllerNoticia,
            entity.titulo,
            '(*) Registre la noticia/evento',
            100,
            2,
            'Ingrese la noticia/evento',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerDetalle,
            entity.objetivo,
            '(*)  Detalle de la noticia/evento',
            140,
            2,
            'Ingrese Detalle de la noticia/evento',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerDirigidoA,
            entity.dirigidoA,
            '(*) Dirigido a:',
            140,
            2,
            'Ingrese quienes participarán',
            true,
            FaIcon(FontAwesomeIcons.userFriends, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerUbicacion,
            entity.ubicacionUrl,
            '(*) Ubicación/Publicación digital del evento',
            160,
            2,
            'Ingrese lugar o ruta digital',
            true,
            FaIcon(FontAwesomeIcons.mapMarked, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _date('(*) Fecha noticia/evento'),
        _hour('(*) Hora noticia/evento'),
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
        style: TextStyle(
            color: AppTheme.themeBlackBlack, fontWeight: FontWeight.bold),
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
        firstDate: new DateTime(2020, 10),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateController.text = _fecha;
        entity.fecha = _inputFieldDateController.text;
        print(_inputFieldDateController.text);
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
      //    locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _time = picked;
        _inputFieldTimeController.text =
            _time.hour.toString() + ':' + _time.minute.toString();
        //TimeOfDay(hour: _time.hour, minute: _time.minute).toString();
        entity.hora = _inputFieldTimeController.text;
      });
    }
  }

  Widget _date(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            hintText: text,
            labelText: text,
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Widget _hour(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldTimeController,
        decoration: InputDecoration(
            hintText: text,
            labelText: text,
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

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idNoticiaEvento =
        (entity.states == StateEntity.Insert) ? 0 : entity.idNoticiaEvento;
    entity.idOrganizacion = int.parse(prefs.idInstitution);
    entity.idPersonal = int.parse(prefs.idPersonal);
    entity.titulo = controllerNoticia.text;
    entity.objetivo = controllerDetalle.text;
    entity.dirigidoA = controllerDirigidoA.text;
    entity.ubicacionUrl = controllerUbicacion.text;
    entity.usuarioAuditoria = prefs.email;
    //  entity.fecha = _inputFieldDateController.text;
    // entity.hora = _inputFieldTimeController.text;
    entity.tipo = _selectedRadio;
  }

  void executeCUD(NewService entityBloc, NoticiaEventoModel entity) async {
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
      setState(() {
        entity.foto = image;
      });
    }
  }
}
