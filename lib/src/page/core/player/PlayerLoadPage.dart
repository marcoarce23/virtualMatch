import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/ClasificadorService.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/service/crudService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;

class PlayerLoadPage extends StatefulWidget {
  static final String routeName = 'playerLoad';

  @override
  _PlayerLoadPageState createState() => _PlayerLoadPageState();
}

class _PlayerLoadPageState extends State<PlayerLoadPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controllerIpsdb = TextEditingController();
  final controllerName = TextEditingController();
  final controllerSecondName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerInformation = TextEditingController();
  final controllerFacebook = TextEditingController();
  final controllerTwitter = TextEditingController();
  final controllerIpsdn = TextEditingController();

  CrudService entityService = new CrudService();
  ImageService entityImage = new ImageService();
  model.JugadorModel entity = new model.JugadorModel();
  ClasificadorService entityGet = ClasificadorService();
  PlayerService entityGet1 = PlayerService();

  final prefs = new Preferense();

  //
  bool _save = false;
  bool _checked = false;
  int valueImage = 0;
  File photo;
  String image = IMAGE_DEFAULT;
  String _opcionDepartamento = '7';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ID PALYER: ${prefs.idPlayer.toString()}');
    entity.states = StateEntity.Insert;
    entity.foto = image;

    final model.JugadorModel entityModel =
        ModalRoute.of(context).settings.arguments;

    if (entityModel != null) {
      entity = entityModel;
      entity.states = StateEntity.Update;
      _checked = true;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('Jugador Virtual Match'.toUpperCase()),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          background(context, ''),
          _form(context),
        ],
      ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
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
            sizedBox(0.0, 5.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
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
    print('DEBERIA SETEAR EL PDSN ${entity.idPsdn}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0.0, 7.0),
        showPictureOval(photo, entity.foto, 70.0),
        dividerBlack(),
        _comboBox('Departamento', _opcionDepartamento),
        _text(
            controllerName,
            entity.nombre,
            '(*) Nombres',
            30,
            '(*) Ingrese nombres del jugador',
            true,
            FaIcon(FontAwesomeIcons.userCircle, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerSecondName,
            entity.apellido,
            '(*) Apellidos',
            30,
            '(*) Ingrese apellidos del cliente',
            true,
            FaIcon(FontAwesomeIcons.userAlt, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerIpsdn,
            entity.idPsdn,
            '(*) ID- PSN/GamerTag',
            15,
            '(*) ID- PSN/GamerTag',
            true,
            FaIcon(FontAwesomeIcons.solidAddressCard,
                color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerPhone,
            entity.telefono,
            '(*) Ingrese WhatsApp',
            10,
            '(*) Ingrese WhatsApp',
            true,
            FaIcon(FontAwesomeIcons.whatsapp, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerInformation,
            entity.informacionComplementaria,
            'Acerca de ti..',
            140,
            'Ingrese sobre ti...',
            false,
            FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            controllerFacebook,
            entity.facebook,
            '(*) Cuenta Facebook/Instagram/Twitter',
            50,
            '(*) Ingressa cuenta Facebook/Instagram/Twitter',
            true,
            FaIcon(FontAwesomeIcons.facebook, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        Row(
          children: [
            sizedBox(10, 0),
            Icon(Icons.remove_red_eye, color: Colors.black),
            _agree(context),
          ],
        ),
        _checkList(),
//        _posibleVenta('Cliente para venta'),

        Text(
          '(*) Campos obligatorios. ',
          style: kCamposTitleStyle,
          textAlign: TextAlign.left,
        ),

        _button('Guardar', 18.0, 20.0),
        // gfCard(),
      ],
    );
  }

  Widget _checkList() {
    return CheckboxListTile(
      title: Text(
        'Acepto los términos de privacidad',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      //   secondary: Text('Si está de acuerdo con los terminos de privacidad, seleccionar '),
      value: _checked,
      controlAffinity: ListTileControlAffinity.platform,
      onChanged: (bool value) {
        setState(() {
          _checked = value;
        });
      },
      activeColor: AppTheme.themeBlackBlack,
      checkColor: AppTheme.themePurple,
    );
  }

  Widget _agree(BuildContext context) {
    return FlatButton(
      child: Text(
        'Revisar Políticas de privacidad'.toUpperCase(),
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      onPressed: () => navegation(
        context,
        ViewPage(
            title: 'Políticas de Privacidad',
            url: 'https://www.virtual_match.bo/politicas-de-privacidad'),
      ),
    );
  }

  Widget _text(
      TextEditingController controller,
      String initialValue,
      String labelText,
      int maxLength,
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

  Widget _comboBox(String label, String values) {
    return Center(
        child: FutureBuilder(
            future: entityGet.get(new ClasificadorModel(), 3),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Text(label),
                    SizedBox(width: 15.0),
                    DropdownButton(
                      icon: FaIcon(FontAwesomeIcons.sort,
                          color: AppTheme.themePurple),
                      value: _opcionDepartamento,
                      items: getDropDown(snapshot),
                      onChanged: (value) {
                        setState(() {
                          _opcionDepartamento = value;
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
    var _result;

    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    print('myControllerSOY EL VALOR DE  ${prefs.idPlayer.toString()}');

    setState(() => _save = true);
    loadingEntity(_result);

    setState(() => _save = false);
  }

  void loadingEntity(var _result) {
    String _url = '/api/Jugador';
    String checked = '0';

    if (!_checked) {
      showSnackbar('Debe aceptar las políticas de privacidad ', scaffoldKey);
      return;
    } else {
      if (entity.states == StateEntity.Insert) {
        entity.idJugador = 0;
      }
      if (entity.states == StateEntity.Update) {
        _url = '/api/Jugador' + '/' + prefs.idPlayer;
      }
      if (_checked) checked = '1';

      entity.idOrganizacion = int.parse(prefs.idOrganization);
      entity.idaDepartamento = int.parse(_opcionDepartamento);
      entity.idLogin = int.parse(prefs.idLogin);
      entity.idPsdn = controllerIpsdn.text;
      entity.nombre = controllerName.text;
      entity.apellido = controllerSecondName.text;
      entity.correo = prefs.email;
      entity.telefono = controllerPhone.text;
      entity.idaSexo = 0;
      entity.informacionComplementaria = controllerInformation.text;
      entity.facebook = controllerFacebook.text;
      entity.twitter = checked;
      entity.usuarioAuditoria = prefs.email;
      executeCUD(entityService, entity, _result, _url);
    }
  }

  void executeCUD(CrudService entityService, JugadorModel entity, var _result,
      String _url) async {
    // String _url = '/api/Jugador';

    // if (prefs.idPlayer != '0')
    //   _url = '/api/Jugador' + '/' + prefs.idPlayer.toString();

    try {
      await entityService.repository(entity, API + _url).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

        if (result["tipo_mensaje"] == '0') {
          if (entity.states == StateEntity.Insert) {
            prefs.idPlayer = result["data"].toString();
          }
          print('EL ID USUARIO ESSS: ${prefs.idPlayer}');
          showSnackbar(result["mensaje"].toString(), scaffoldKey);
        } else
          showSnackbar(result["mensaje"].toString(), scaffoldKey);
      });
    } catch (error) {
      showSnackbar('Se produjo un error.${error.toString()} ', scaffoldKey);
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

        //print('cargadod e iagen ${entity.foto}');
      });
    }
  }
}
