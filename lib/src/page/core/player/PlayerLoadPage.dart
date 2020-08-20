import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentLoadPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/ClasificadorService.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/image/ImageWidget.dart';

class PlayerAllPage extends StatefulWidget {
  static final String routeName = 'player';
  const PlayerAllPage({Key key}) : super(key: key);

  @override
  _PlayerAllPagePageState createState() => _PlayerAllPagePageState();
}

class _PlayerAllPagePageState extends State<PlayerAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [
    PlayerLoadPage(),
    PlayerListTeams(),
    PlayerWithTournement()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = PlayerAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => new PlayerService()),
      ],
      child: Scaffold(
        appBar: appBar('JUGADOR VIRTUAL MATCH'),
        drawer: DrawerMenu(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 21.0,
          backgroundColor: AppTheme.themeDefault,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.gamepad,
                  size: 25,
                ),
                title: Text('Jugador VM')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.futbol,
                  size: 25,
                ),
                title: Text('Tus equipos')),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.playstation,
                  size: 25,
                ),
                title: Text('Torneos')),
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

class PlayerListTeams extends StatefulWidget {
  PlayerListTeams({Key key}) : super(key: key);

  @override
  _PlayerListTeamsState createState() => _PlayerListTeamsState();
}

class _PlayerListTeamsState extends State<PlayerListTeams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            itemPlayer(),
            divider(),
            Text("Tus equipos"),
            divider(),
            itemTeam()
          ],
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.plus), EquipmentLoadPage()),
    );
  }

  Widget itemPlayer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          gfListTile(
              Text("Jugador: Marco Antonio Arce Valdivia"),
              null,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("# 150 partidos Jugados"),
                  Text("# 100 Ganados"),
                  Text("# 50 Perdidos"),
                ],
              ),
              null,
              avatarCircle(IMAGE_DEFAULT, 35),
              EdgeInsets.all(5.0),
              EdgeInsets.all(3.0)),
        ],
      ),
    );
  }

  Widget itemTeam() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          gfListTile(
              Text("Bomberos teams"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("#15 partidos jugados"),
                  Text("#10 Ganados"),
                  Text("#5 Perdidos"),
                ],
              ),
              null,
              null,
              avatarCircle(IMAGE_DEFAULT, 35),
              EdgeInsets.all(5.0),
              EdgeInsets.all(3.0)),
        ],
      ),
    );
  }
}

class PlayerWithTournement extends StatefulWidget {
  PlayerWithTournement({Key key}) : super(key: key);

  @override
  _PlayerWithTournementState createState() => _PlayerWithTournementState();
}

class _PlayerWithTournementState extends State<PlayerWithTournement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            itemPlayer(),
            divider(),
            Text("Torneos disponbles"),
            divider(),
            itemTournament(),
            itemTournament(),
          ],
        ),
      ),
    );
  }

  Widget itemPlayer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          gfListTile(
              Text("Jugador: Marco Antonio Arce Valdivia"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("# 150 partidos Jugados"),
                  Text("# 100 Ganados"),
                  Text("# 50 Perdidos"),
                ],
              ),
              Text(""),
              null,
              avatarCircle(IMAGE_DEFAULT, 35),
              EdgeInsets.all(5.0),
              EdgeInsets.all(3.0)),
        ],
      ),
    );
  }

  Widget itemTournament() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          gfListTile(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Torneo Wistupiku"),
                  Text("126/128"),
                ],
              ),
              Text("Eliminatoria"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Torneo relampago para eliminatoria "),
                  Text("Del 01/01/2020 al 31/08/2020 "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GFButton(
                        onPressed: () {},
                        text: "Inscribirse",
                      ),
                      Text("2 días para cerrar"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      GFImageOverlay(
                          height: 20,
                          width: 20,
                          shape: BoxShape.circle,
                          image: NetworkImage(IMAGE_DEFAULT)),
                          GFImageOverlay(
                          height: 20,
                          width: 20,
                          shape: BoxShape.circle,
                          image: NetworkImage(IMAGE_DEFAULT)),
                          GFImageOverlay(
                          height: 20,
                          width: 20,
                          shape: BoxShape.circle,
                          image: NetworkImage(IMAGE_DEFAULT)),
                          GFImageOverlay(
                          height: 20,
                          width: 20,
                          shape: BoxShape.circle,
                          image: NetworkImage(IMAGE_DEFAULT)),
                          Text(" + 126 jugadores inscritos")

                    ],
                  )
                ],
              ),
              null,
              avatarCircle(IMAGE_DEFAULT, 35),
              EdgeInsets.all(5.0),
              EdgeInsets.all(3.0)),
        ],
      ),
    );
  }
}

class PlayerLoadPage extends StatefulWidget {
  static final String routeName = 'playerLoad';

  @override
  _PlayerLoadPageState createState() => _PlayerLoadPageState();
}

class _PlayerLoadPageState extends State<PlayerLoadPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();

  PlayerService entityService;
  ImageService entityImage = new ImageService();
  JugadorModel entity = new JugadorModel();
  ClasificadorService entityGet = ClasificadorService();
  final prefs = new Preferense();

  //
  bool _save = false;
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
    entity.states = StateEntity.Insert;
    entityService = Provider.of<PlayerService>(context);

    final JugadorModel entityModel = ModalRoute.of(context).settings.arguments;

    if (entityModel != null) {
      entity = entityModel;
      entity.states = StateEntity.Update;
    }

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          background(context, ''),
          // crearFondo(context, imagen),
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
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  text('CARGA TU AVATAR EN LA APP.  ', AppTheme.themeDefault, 1,
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
            copyRigth(),
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
        divider(),

        //     _tipo('Departamento : ', getTipo()),
        _comboBox('Departamento', _opcionDepartamento),

        _text(
            myController,
            'Marcelo Antonio',
            'Nombres',
            40,
            'Ingrese nombres del jugador',
            true,
            FaIcon(FontAwesomeIcons.userCircle, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            'Arce Valdivia',
            'Apellidos del jugador',
            40,
            'Ingrese apellidos del cliente',
            true,
            FaIcon(FontAwesomeIcons.userAlt, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            myController,
            '',
            'Codigo PDSN',
            40,
            'Ingrese Codigo PSDN/Registro',
            true,
            FaIcon(FontAwesomeIcons.solidAddressCard,
                color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            myController,
            'marco.arce@gmail.com',
            'Telefono WhatsApp',
            40,
            'Ingrese Telefono WhatsApp',
            true,
            FaIcon(FontAwesomeIcons.whatsapp, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            'marco.arce@gmail.com',
            'Acerca de ti..',
            40,
            'Ingrese sobre ti...',
            true,
            FaIcon(FontAwesomeIcons.mailBulk, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            '72038768',
            'Ingressa cuenta Faceook',
            40,
            'Ingrese el telefono de contacto',
            true,
            FaIcon(FontAwesomeIcons.facebook, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

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
                          color: AppTheme.themeDefault),
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

    print('myControllerSOY EL VALOR DE ' + myController.text);

    setState(() => _save = true);
    loadingEntity();
    executeCUD(entityService, entity, _result);
    setState(() => _save = false);
  }

  void loadingEntity() {
    entity.idJugador = 0;
    entity.idOrganizacion = prefs.idInstitution;
    entity.idaDepartamento = int.parse(_opcionDepartamento);
    entity.idLogin = prefs.userId;
    entity.idPsdn = '2468';
    entity.nombre = 'maro antonio';
    entity.apellido = 'arce';
    entity.correo = prefs.email;
    entity.telefono = '72038768';
    entity.idaSexo = 0;
    entity.informacionComplementaria = 'me gusta jugar';
    entity.facebook = '@facebookmarce';
    entity.twitter = '@marce3452';
    entity.foto = IMAGE_LOGO;
    entity.usuarioAuditoria = prefs.email;
    entity.fechaAuditoria = '2020-08-10 08:25';
  }

  void executeCUD(
      PlayerService entityService, JugadorModel entity, var _result) async {
    try {
      await entityService.repository(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

        if (result["tipo_mensaje"] == '0')
          showSnackbar('Registro con éxito.', scaffoldKey);
        else
          showSnackbar('Se produjo un error. Vuelva a intentarlo', scaffoldKey);
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
