import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/EquipoModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/TorneoModelo.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
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
  final List<Widget> optionPage = [
    TourmentLoadPage(),
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
  final controllerNoticia = TextEditingController();
  final controllerDetalle = TextEditingController();
  final controllerDirigidoA = TextEditingController();
  final controllerUbicacion = TextEditingController();
//DEFINICION DE BLOC Y MODEL
  TourmentService entityService;
  TorneoModel entity = new TorneoModel();
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

        _text(
            controllerNoticia,
            entity.nombre,
            'NOTICIA'.toUpperCase(),
            100,
            2,
            'Ingrese la noticia',
            true,
            FaIcon(FontAwesomeIcons.newspaper, color: AppTheme.themeGrey),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerDetalle,
            entity.detalle,
            'Detalle de la noticia',
            140,
            2,
            'Ingrese Detalle de la noticia',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: Colors.black26),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        // _text(
        //     controllerDirigidoA,
        //     entity.titulo,
        //     'PARTICIPANTES'.toUpperCase(),
        //     140,
        //     2,
        //     'Ingrese quienes participan',
        //     true,
        //     FaIcon(FontAwesomeIcons.userFriends, color: AppTheme.themeGrey),
        //     AppTheme.themeDefault,
        //     AppTheme.themeDefault,
        //     Colors.red),
        // _text(
        //     controllerUbicacion,
        //     entity.titulo,
        //     'UBICACIÓN'.toUpperCase(),
        //     160,
        //     2,
        //     'Ingrese lugar o ruta digital',
        //     true,
        //     FaIcon(FontAwesomeIcons.mapMarked, color: AppTheme.themeGrey),
        //     AppTheme.themeDefault,
        //     AppTheme.themeDefault,
        //     Colors.red),
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
    entity.idTorneo = 0;
    entity.idOrganizacion = 133;
    // entity.nombre = controllerNoticia.text;
    // entity.detalle = controllerDetalle.text;
    entity.foto = IMAGE_LOGO;
    entity.usuarioAuditoria = prefs.email;
    entity.fechaAuditoria = '2020-08-10 08:25';
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
