import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NotificacionModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;

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
    FormatTourmentPage(),
    FormatTourmentPage()
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
        ChangeNotifierProvider(builder: (_) => new NotificationService()),
      ],
      child: Scaffold(
        appBar: appBar('TORNEOS'),
        drawer: DrawerMenu(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 21.0,
          backgroundColor: AppTheme.themeDefault,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.bell,
                  size: 25,
                ),
                title: Text('Formato')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.listAlt,
                  size: 25,
                ),
                title: Text('Eliminatorias')),
          ],
          currentIndex: page,
          unselectedItemColor: AppTheme.themeWhite,
          selectedItemColor: AppTheme.themePurple,
          onTap: _onItemTapped,
        ),
        body: optionPage[page],
      ),
    );
  }
}

class FormatTourmentPage extends StatefulWidget {
  static final String routeName = 'notificationLoad';

  @override
  _FormatTourmentPageState createState() => _FormatTourmentPageState();
}

class _FormatTourmentPageState extends State<FormatTourmentPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerTitulo = TextEditingController();
  final controllerDetalle = TextEditingController();

//DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  NotificationService entityService;
  final prefs = new Preferense();

  //DEFINICION DE VARIABLES
  bool _save = false;
  File photo;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    entityService = Provider.of<NotificationService>(context);
    entity.states = StateEntity.Insert;

    final NotificacionModel entityModel =
        ModalRoute.of(context).settings.arguments;

    if (entityModel != null) {
      entity = entityModel;
      entity.states = StateEntity.Update;
    }

    // return ChangeNotifierProvider(
    //   builder: (_) => new NotificationService(),
    //   child:

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          background(context, 'IMAGE_LOGO'),
          // showPictureOval(photo, IMAGE_DEFAULT, 130.0),
          //   crearFondo(context, IMAGE_LOGO),

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
            sizedBox(0.0, 7.0),
            showInformation(
                context,
                'GESTIONA LAS NOTIFICACIONES',
                'En la pantalla podrás crear y modficar las notificaciones.\nLos campos con (*) son obligatorios.',
                'Visita Sorojchi eclub en facebook',
                'INGRESASTE A SORIJCHI ECLUB',
                'https://www.facebook.com/SorojchieClub/'),
            sizedBox(0.0, 5.0),
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
        _text(
            controllerTitulo,
            entity.titulo,
            'NOTIFICACIÓN'.toUpperCase(),
            100,
            3,
            'Ingrese la notificación',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerDetalle,
            entity.detalle,
            'DETALLE DE LA NOTIFICACION',
            140,
            4,
            'Ingrese Detalle de la notificación',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
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
        initialValue: initialValue,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: true,
        maxLength: maxLength,
        autocorrect: true,
        autovalidate: false,
        maxLines: maxLines,
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
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    print('myControllerSOY EL VALOR DE ' + controllerTitulo.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityService, entity);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idNotificacion = 0;
    entity.idOrganizacion = 1;
    entity.titulo = controllerTitulo.text;
    entity.detalle = controllerDetalle.text;
    entity.usuarioAuditoria = prefs.email;
    entity.foto = IMAGE_LOGO;
    entity.fechaAuditoria = '2020-08-10 08:25';
    // entity.states = StateEntity.Insert;

    print('EL ENTITY NOTIFICA: ${entity.detalle}');
  }

  void executeCUD(
      NotificationService entityService, NotificacionModel entity) async {
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
