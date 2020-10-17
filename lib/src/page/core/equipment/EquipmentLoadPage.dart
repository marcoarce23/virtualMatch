import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/EquipoModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentListPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerEditPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerEquipmentPage.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardSlideProductWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/EquipoModel.dart'
    as gets;

class EquipmentAllPage extends StatefulWidget {
  static final String routeName = 'equipment';
  const EquipmentAllPage({Key key}) : super(key: key);

  @override
  _EquipmentAllPageState createState() => _EquipmentAllPageState();
}

class _EquipmentAllPageState extends State<EquipmentAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [
    EquipmentLoadPage(),
    EquipmentListPage(),
    PlayerEquipmentPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = EquipmentAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ignore: missing_required_param
        ChangeNotifierProvider(builder: (_) => new EquipmentService()),
      ],
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 21.0,
          backgroundColor: AppTheme.themeDefault,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/image/pelota.png',
                  //scale: 0.4,
                  width: 28,
                  height: 28,
                ),
                title: Text('Tu equipo')),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/image/penal.png',
                  //scale: 0.4,
                  width: 28,
                  height: 28,
                ),
                title: Text('Editar equipo')),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/image/jugador2.png',
                  //scale: 0.4,
                  width: 28,
                  height: 28,
                ),
                title: Text('Tus jugadores')),
          ],
          currentIndex: page,
          unselectedItemColor: AppTheme.themeWhite,
          selectedItemColor: Colors.purple,
          onTap: _onItemTapped,
        ),
        body: optionPage[page],
      ),
    );
  }
}

class EquipmentLoadPage extends StatefulWidget {
  static final String routeName = 'equipmentLoad';

  @override
  _EquipmentLoadPageState createState() => _EquipmentLoadPageState();
}

class _EquipmentLoadPageState extends State<EquipmentLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerNoticia = TextEditingController();
  final controllerDetalle = TextEditingController();
  final controllerDirigidoA = TextEditingController();
  final controllerUbicacion = TextEditingController();
//DEFINICION DE BLOC Y MODEL
  gets.EquipoModel entityModelGet = new gets.EquipoModel();
  EquipmentService entityService;
  EquipoModel entity = new EquipoModel();
  ImageService entityImage = new ImageService();
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  File photo;
  String image = IMAGE_DEFAULT;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entity.foto = image;
    entity.states = StateEntity.Insert;
    entity.agrupador = 0;
    entityService = Provider.of<EquipmentService>(context);

    final gets.EquipoModel entityModelGet =
        ModalRoute.of(context).settings.arguments;

    if (entityModelGet != null) {
      entity.detalle = entityModelGet.detalle;
      entity.nombre = entityModelGet.nombre;
      entity.foto = entityModelGet.foto;
      entity.agrupador = entityModelGet.agrupador;
      entity.states = StateEntity.Update;
      print(entity.detalle);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('CREA TU EQUIPO'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          showPictureOval(photo, IMAGE_LOGO, 130.0),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.playstation), PlayerEditPage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  text('CARGA AVATAR DE TU EQUIPO', AppTheme.themeDefault, 1,
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
            sizedBox(0.0, 5.0),
            CardSlideWidget(),
            sizedBox(0.0, 5.0),
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
        _text(
            controllerNoticia,
            entity.nombre,
            'Nombre de tu equipo',
            100,
            2,
            'Ingrese el nombre del equipo',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerDetalle,
            entity.detalle,
            'Escribe sobre tu equipo',
            140,
            2,
            'Ingrese Detalle del equipo',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
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

    print('myControllerSOY EL VALOR DE ' + controllerDetalle.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idEquipo =
        (entity.states == StateEntity.Insert) ? 0 : entity.idEquipo;
    entity.idJugador = int.parse(prefs.idPlayer);
    entity.nombre = controllerNoticia.text;
    entity.detalle = controllerDetalle.text;
    entity.usuarioAuditoria = prefs.email;

    entity.esCapitan = 1;
  }

  void executeCUD(EquipmentService entityService, EquipoModel entity) async {
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
      print('imagennnnn $image');
      setState(() {
        entity.foto = image;
        //print('cargadod e iagen ${entity.foto}');
      });
    }
  }
}
