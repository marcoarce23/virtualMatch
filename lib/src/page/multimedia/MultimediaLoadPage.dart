import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/MultimediaModel.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/page/multimedia/MultimediaListPage.dart';
import 'package:virtual_match/src/service/ClasificadorService.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/MultimediaService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/MultimediaModel.dart'
    as gets;

class MultimediaAllPage extends StatefulWidget {
  static final String routeName = 'multimedia';
  const MultimediaAllPage({Key key}) : super(key: key);

  @override
  _MultimediaAllPageState createState() => _MultimediaAllPageState();
}

class _MultimediaAllPageState extends State<MultimediaAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [MultimediaLoadPage(), MultimediaListPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = MultimediaAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(builder: (_) => new MultimediaService()),
        //   ],
        //  child:
        Scaffold(
      //    appBar: appBar('GALERÍA MULTIMEDIA'),
      //   drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 21.0,
        backgroundColor: AppTheme.themeDefault,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/image/papelvideo.png',
                width: 28,
                height: 28,
              ),
              title: Text('Multimedia')),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/image/multimeda3.png',
                width: 28,
                height: 28,
              ),
              title: Text('Galería Multimedia')),
        ],
        currentIndex: page,
        unselectedItemColor: AppTheme.themeWhite,
        selectedItemColor: AppTheme.themePurple,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
      //   ),
    );
  }
}

class MultimediaLoadPage extends StatefulWidget {
  static final String routeName = 'newMultimedia';

  @override
  _MultimediaLoadPageState createState() => _MultimediaLoadPageState();
}

class _MultimediaLoadPageState extends State<MultimediaLoadPage> {
  //DEFINIICON DE VARIABLES GLOBALES
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controllerNoticia = TextEditingController();
  final controllerDetalle = TextEditingController();
  final controllerDirigidoA = TextEditingController();
  final controllerUbicacion = TextEditingController();
  TextEditingController _inputFieldDateInicioController =
      new TextEditingController();
  TextEditingController _inputFieldDateFinController =
      new TextEditingController();

//DEFINICION DE BLOC Y MODEL
  MultimediaService entityService = new MultimediaService();
  MultimediaModel entity = new MultimediaModel();
  ClasificadorService entityGet = ClasificadorService();
  ImageService entityImage = new ImageService();
  final prefs = new Preferense();
  gets.MultimediaModel entityGet1 = new gets.MultimediaModel();

  //DEFINICION DE VARIABLES
  bool _save = false;
  File photo;
  String _fecha = '';
  int typeMaterial = 14;
  int valueImage = 0;
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

    final gets.MultimediaModel entityModelGet =
        ModalRoute.of(context).settings.arguments;

    if (entityModelGet != null) {
      entity.states = StateEntity.Update;
      if (unaVez == 0) {
        entity.idMultimedia = entityModelGet.idMultimedia;
        entity.titulo = entityModelGet.titulo;
        entity.resumen = entityModelGet.resumen;
        _inputFieldDateInicioController.text = entityModelGet.fechainicio;
        _inputFieldDateFinController.text = entityModelGet.fechafin;
        entity.foto = entityModelGet.foto;
        image = entityModelGet.foto;
      }
      print(entity.foto);
    }
    unaVez = 1;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('GALERÍA DE IMÁGENES'),
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
        child: Container(
          color: Colors.black54,
          child: Column(
            children: <Widget>[
              sizedBox(0.0, 8.0),
              Container(
                width: size.width * 0.94,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: containerImage(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    text('   CARGAR  GALERÍA DE IMÁGENES',
                        AppTheme.themeDefault, 1, 13.5),
                    _crearIconAppImagenes(),
                    _crearIconAppCamara(),
                    //    _crearIconAppVideo(),
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
              divider(),
            ],
          ),
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
        //    _combox('Seleccionar multimedia:'.toUpperCase()),
        _text(
            controllerNoticia,
            entity.titulo,
            '(*) Nombre material imágenes',
            100,
            2,
            'Ingrese el nombre del material imágenes',
            true,
            FaIcon(FontAwesomeIcons.images, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        _text(
            controllerDetalle,
            entity.resumen,
            '(*) Detalle del material imágenes',
            140,
            2,
            'Ingrese detalle del material imágenes',
            true,
            FaIcon(FontAwesomeIcons.wpforms, color: AppTheme.themeDefault),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        // _text(
        //     controllerUbicacion,
        //     entity.enlace,
        //     '(*) Enlace digital del torneo',
        //     140,
        //     2,
        //     '(*) Ingrese enlace del torneo (facebook, youtube)',
        //     true,
        //     FaIcon(FontAwesomeIcons.link, color: AppTheme.themeDefault),
        //     AppTheme.themeDefault,
        //     AppTheme.themeDefault,
        //     Colors.red),
        _initDate('(*) Fecha de inicio de la publicación'),
        _endDate('(*) Fecha de conclusión de la publicación'),
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

  _selectDateInicio(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 10),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateInicioController.text = _fecha;
        entity.fechaInicio = _inputFieldDateInicioController.text;
      });
    }
  }

  _selectDateFin(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 10),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateFinController.text = _fecha;
        entity.fechaFin = _inputFieldDateFinController.text;
      });
    }
  }

  Widget _initDate(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateInicioController,
        decoration: InputDecoration(
            hintText: text,
            labelText: text,
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateInicio(context);
        },
      ),
    );
  }

  Widget _endDate(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateFinController,
        decoration: InputDecoration(
            hintText: text,
            labelText: text,
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeDefault)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateFin(context);
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
    entity.idMultimedia =
        (entity.states == StateEntity.Insert) ? 0 : entity.idMultimedia;
    entity.idOrganizacion = 1;

    entity.idOrganizacion = int.parse(prefs.idOrganization);
    entity.idaCategoria = 14; //typeMaterial;
    entity.titulo = controllerNoticia.text;
    entity.resumen = controllerDetalle.text;
    entity.fechaInicio = _inputFieldDateInicioController.text;
    entity.fechaFin = _inputFieldDateFinController.text;
    entity.usuarioAuditoria = prefs.email;
    // entity.fechaAuditoria = '2020-08-10 08:25';
    entity.enlace = ''; // controllerUbicacion.text;
  }

  void executeCUD(
      MultimediaService entityService, MultimediaModel entity) async {
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

        print('cargadod e iagen ${entity.foto}');
      });
    }
  }

  // _procesarVideo2(String file) async {
  //   valueImage = 2;

  //   image = await entityImage.uploadVideo(file);
  //   setState(() {
  //     entity.foto = IMAGE_LOGO;
  //     print('cargadod e iagen ${entity.foto}');
  //   });
  // }

  // void _pickVideo() async {
  //   try {
  //     var _extension = 'MP4';
  //     _pdfPath = await FilePicker.getFilePath(
  //         type: FileType.custom,
  //         allowedExtensions: (_extension?.isNotEmpty ?? false)
  //             ? _extension?.replaceAll(' ', '')?.split(',')
  //             : null);

  //     setState(() {});
  //     if (_pdfPath == '') {
  //       return;
  //     }
  //     _procesarVideo2(_pdfPath);
  //   } on PlatformException catch (exception) {
  //     showSnackbar('Se produjo un error. $exception', scaffoldKey);
  //   }
  // }
}
