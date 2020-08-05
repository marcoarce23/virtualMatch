import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:virtual_match/src/model/entity/EntityMap/ProductModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/ImageService.dart';
import 'package:virtual_match/src/service/core/AlbumService.dart';

import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';

import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/image/ImageWidget.dart';
import 'package:virtual_match/src/model/util/Validator.dart' as validator;

class AlbumAllPage extends StatefulWidget {
  static final String routeName = 'productAll';
  const AlbumAllPage({Key key}) : super(key: key);

  @override
  _AlbumAllPageState createState() => _AlbumAllPageState();
}

class _AlbumAllPageState extends State<AlbumAllPage> {
  int page = 0;
  final prefs = new Preferense();
  final List<Widget> optionPage = [AlbumLoadPage(), AlbumLoadPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = AlbumAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeGrey, size: 12),
        elevation: 0,
        title: Text("CREAR TU ALBUM", style: kTitleAppBar),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       // showSearch(context: context, delegate: DataSearchVoluntary());
        //     },
        //   )
        // ],
      ),
      drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.shoppingBag,
                size: 25,
              ),
              title: Text('Crear')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.store,
                size: 25,
              ),
              title: Text('Tu Album')),
        ],
        currentIndex: page,
        unselectedItemColor: Colors.black54,
        selectedItemColor: AppTheme.themeDefault,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class AlbumLoadPage extends StatefulWidget {
  static final String routeName = 'loadProduct';

  @override
  _AlbumLoadPagePageState createState() => _AlbumLoadPagePageState();
}

class _AlbumLoadPagePageState extends State<AlbumLoadPage> {
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();

  AlbumService entityBloc;
  ImageService entityImage = new ImageService();
  ProductModel entity = new ProductModel();
  bool _save = false;
  int valueImage = 0;
  File photo;
  String image = IMAGE_DEFAULT;
  String imagePDF =
      'https://res.cloudinary.com/propia/image/upload/v1592950093/rohprekln9plcyolgw0d.jpg';
  String imageVideo =
      'https://res.cloudinary.com/propia/image/upload/v1592950136/hy2vrcig1hwdikhjzx2b.jpg';
  String _pdfPath = '';
  List<String> _listTipo = [
    'Trimestral 2020',
    'Año nuevo 2020',
    'Primavera Familiar',
    'Epoca de Comprar',
    'Trimestral 2019',
    'Año nuevo 2019',
  ];
  String _opcionTipo = '';

  @override
  void initState() {
    _opcionTipo = 'Trimestral 2020';
    // prefs.ultimaPagina = CitizenHelpModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (valueImage == 0) image = image;
    if (valueImage == 1) image = imagePDF;
    if (valueImage == 2) image = imageVideo;

    final ProductModel entityModel = ModalRoute.of(context).settings.arguments;

    if (entityModel != null) {
      entity = entityModel;
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
      floatingActionButton: floatButton(AppTheme.themeGrey, context,
          FaIcon(FontAwesomeIcons.home), HomePage()),
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
                  text('CARGAR ALBUM DE IMÁGENES', AppTheme.themeBlackGrey, 1,
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
        color: AppTheme.themeBlackGrey,
      ),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: Icon(
        Icons.camera_alt,
        color: AppTheme.themeBlackGrey,
      ),
      onPressed: _tomarFoto,
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0.0, 7.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: textSimple1(
              FaIcon(FontAwesomeIcons.images, color: AppTheme.themeBlackGrey),
              'Imágen del Album',
              AppTheme.themeBlackGrey),
        ),
        showPictureOval(photo, image, 130.0),
        divider(),

        _text(
            myController,
            'Catálogo Julio 2020',
            'Nombre del Album'.toUpperCase(),
            40,
            'Ingrese nombre del catálogo',
            true,
            FaIcon(FontAwesomeIcons.checkCircle, color: Colors.black26),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),

        _text(
            myController,
            'Catálogo que contempla las URbanizaciones San Francisco, Auizañama',
            'Detalle del Album'.toUpperCase(),
            40,
            'Ingrese Detalle del catálogo',
            true,
            FaIcon(FontAwesomeIcons.checkCircle, color: Colors.black26),
            AppTheme.themeDefault,
            AppTheme.themeDefault,
            Colors.red),
        //  _comboBox('Tipo.', myController.text),
        _tipo(),
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

  // Widget _double() {
  //   return TextFormField(
  //     initialValue: 23.toString(),
  //     keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     decoration: InputDecoration(labelText: 'Precio'),
  //     onSaved: (value) => entity.eveDirigidoA = value,
  //     validator: (value) {
  //       // if ( utils.isNumeric(value)  ) {
  //       //   return null;
  //       // } else {
  //       return 'Sólo números';
  //       // }
  //     },
  //   );
  // }
  List<DropdownMenuItem<String>> getTipo() {
    List<DropdownMenuItem<String>> lista = new List();

    _listTipo.forEach((tipoPrioridad) {
      lista.add(DropdownMenuItem(
        child: Text(tipoPrioridad),
        value: tipoPrioridad,
      ));
    });
    return lista;
  }

  Widget _tipo() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Seleccionar Tipo:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionTipo,
          icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeDefault),
          items: getTipo(),
          onChanged: (value) {
            setState(() {
              _opcionTipo = value;
            });
          },
        ),
      ],
    );
  }

  Widget _comboBox(String label, String values) {
    return Center(child: FutureBuilder(
        // future: generic.getAll(new GetClasificador(),
        //     urlGetClasificador + '53', primaryKeyGetClasifidor),
        builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return Row(
          children: <Widget>[
            SizedBox(width: 35.0),
            Text(label),
            SizedBox(width: 15.0),
            DropdownButton(
              icon: FaIcon(FontAwesomeIcons.sort, color: AppTheme.themeDefault),
              value: values,
              items: getDropDown(snapshot),
              onChanged: (value) {
                setState(() {
                  values = value;
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
      // GetClasificador item = snapshot.data[i];
      final item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),
      ));
    }
    return lista;
  }

  Widget _button(String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeGrey,
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
    executeCUD(entityBloc, entity, _result);
    setState(() => _save = false);
  }

  void loadingEntity() {
    // entity.idBrandModel = 0;
    // entity.brand = myController.text;
    // entity.model = 'objetivo.objectValue';
    // entity.type = 'objetivo.objectValue';
    // entity.user = 'marce';
    // entity.photo =
    //     'https://res.cloudinary.com/propia/image/upload/v1594411679/fqnpfloqjctcbwja3pfy.jpg';
    // entity.states = StateEntity.Insert;
  }

  void executeCUD(
      AlbumService entityBloc, ProductModel entity, var _result) async {
    try {
      await entityBloc.repository(entity).then((respuesta) {
        loading();

        _result = respuesta["TIPO_RESPUESTA"];

        if (_result == '0')
          showSnackbar('Registro con éxito.', scaffoldKey);
        else
          showSnackbar('Se produjo un error. Vuelva a intentarlo', scaffoldKey);
      });
    } catch (error) {
      showSnackbar('Se produjo un error.${error.toString()} ', scaffoldKey);
    }
  }

  _seleccionarFoto() async {
    valueImage = 0;

    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    valueImage = 0;
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    photo = await ImagePicker.pickImage(source: origen);

    if (photo != null) {
      image = await entityImage.uploadImageFile(photo);
      setState(() {
        entity.foto = image;

        //print('cargadod e iagen ${entity.foto}');
      });
    }
  }

  _procesarFile(String file) async {
    valueImage = 1;

    if (photo != null) {
      image = await entityImage.uploadImage(file);
      setState(() {
        entity.foto = image;
        //print('cargadod e iagen ${entity.foto}');
      });
    }
  }

  _procesarVideo2(String file) async {
    valueImage = 2;

    image = await entityImage.uploadVideo(file);
    setState(() {
      entity.foto = image;
      //print('cargadod e iagen ${entity.foto}');
    });
  }

  void _pickPDF() async {
    try {
      var _extension = 'PDF';
      _pdfPath = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);

      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      valueImage = 1;
      _procesarFile(_pdfPath);
    } on PlatformException catch (exception) {
      showSnackbar('Se produjo un error. $exception', scaffoldKey);
    }
  }

  void _pickVideo() async {
    try {
      var _extension = 'MP4';
      _pdfPath = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);

      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      //print("File path11: " + _pdfPath);
      _procesarVideo2(_pdfPath);
      // setState(() {
      //   _isLoading = true;
      // });
    } on PlatformException catch (exception) {
      showSnackbar('Se produjo un error. $exception', scaffoldKey);
    }
  }
}
