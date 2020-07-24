import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:virtual_match/src/bloc/Event/EventBloc.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityMap.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/provider/provider.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';

import 'package:getwidget/getwidget.dart';

class EventAllPage extends StatefulWidget {
  static final String routeName = 'voluntarioz';
  const EventAllPage({Key key}) : super(key: key);

  @override
  _EventAllPageState createState() => _EventAllPageState();
}

class _EventAllPageState extends State<EventAllPage> {
  final prefs = new Preferense();

  int page = 0;
  final List<Widget> optionPage = [EventModule(), EventAllPage()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.lastPage = EventAllPage.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeDefault, size: 12),
        elevation: 0,
        title: Text("EVENTOS", style: kTitleAppBar),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // showSearch(context: context, delegate: DataSearchVoluntary());
            },
          )
        ],
      ),
      // drawer: DrawerCitizen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.chalkboardTeacher,
                size: 25,
              ),
              title: Text('Eventos')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarAlt,
                size: 25,
              ),
              title: Text('Listado eventos')),
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

class EventModule extends StatefulWidget {
  static final String routeName = 'event';

  @override
  _EventModuleState createState() => _EventModuleState();
}

class _EventModuleState extends State<EventModule> {
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

  EventBloc entityBloc;
  EventModel entity = new EventModel();
  bool _guardando = false;
  File foto;

  String titulo;

  @override
  Widget build(BuildContext context) {
    entityBloc = Provider.eventBloc(context);

    final EventModel entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) {
      entity = entityData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // _mostrarFoto(),
                //aeropuerto.widget,
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),

                GFProgressBar(
                    percentage: 0.9,
                    width: 100,
                    radius: 90,
                    backgroundColor: Colors.black26,
                    progressBarColor: GFColors.DANGER),

                GFProgressBar(
                  percentage: 0.8,
                  lineHeight: 20,
                  alignment: MainAxisAlignment.spaceBetween,
                  child: const Text(
                    '80%',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  leading: Icon(Icons.sentiment_dissatisfied,
                      color: GFColors.DANGER),
                  trailing:
                      Icon(Icons.sentiment_satisfied, color: GFColors.SUCCESS),
                  backgroundColor: Colors.black26,
                  progressBarColor: GFColors.INFO,
                ),

                GFProgressBar(
                  percentage: 0.5,
                  lineHeight: 20,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      '50%',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.black26,
                  progressBarColor: GFColors.WARNING,
                ),

                GFCarousel(
                  items: imageList.map(
                    (url) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(url,
                              fit: BoxFit.cover, width: 1000.0),
                        ),
                      );
                    },
                  ).toList(),
                  onPageChanged: (index) {
                    setState(() {
                      index;
                    });
                  },
                ),

                GFCard(
                  boxFit: BoxFit.cover,
                  image: Image.asset('your asset image'),
                  title: GFListTile(
                      title: Text('Card Title'),
                      icon: GFIconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite_border),
                        type: GFButtonType.transparent,
                      )),
                  content: Text("Some quick example text to build on the card"),
                  buttonBar: GFButtonBar(
                    alignment: WrapAlignment.start,
                    children: <Widget>[
                      GFButton(
                        onPressed: () {},
                        text: 'Read More',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: entity.eveTitulo,
      controller: myController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      // onSaved: (value) => entity.eveTitulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: 23.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => entity.eveDirigidoA = value,
      validator: (value) {
        // if ( utils.isNumeric(value)  ) {
        //   return null;
        // } else {
        return 'Sólo números';
        // }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: true,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        //producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    var _result;

    // if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print(
        '############################# SOY EL VALOR DE ###############################' +
            myController.text);

    setState(() => _guardando = true);
    loadingEntity();
    executeCUD(entityBloc, entity, _result);
    setState(() => _guardando = false);
  }

  void loadingEntity() {
    entity.idcovEvento = 0;
    entity.idcovInstitucion = 111;
    entity.idcovPersonal = 222;
    entity.eveTitulo = myController.text;
    entity.eveObjetivo = 'objetivo.objectValue';
    entity.eveDirigidoA = 'dirigidoA.objectValue';
    entity.eveExpositor = 'expositor.objectValue';
    entity.eveUbicacion = 'ubicacion.objectValue';
    entity.eveFecha = '01/01/2020';
    entity.eveHora = '08:23';
    entity.usuario = 'marce';
    entity.eveFoto = 'url foto1';
    entity.states = StateEntity.Insert;
  }

  void executeCUD(EventBloc entityBloc, EventModel entity, var _result) async {
    try {
      await entityBloc.repository(entity).then((respuesta) {
        _result = respuesta["TIPO_RESPUESTA"];

        if (_result == '0')
          mostrarSnackbar('Registro guardado');
        else
          mostrarSnackbar('Errrorrrrr');
      });
    } catch (error) {
      mostrarSnackbar('Errrorrrrr ');
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    // if ( producto.fotoUrl != null ) {

    //   return FadeInImage(
    //     image: NetworkImage( producto.fotoUrl ),
    //     placeholder: AssetImage('assets/jar-loading.gif'),
    //     height: 300.0,
    //     fit: BoxFit.contain,
    //   );

    // } else {

    //   return Image(

    //     image: AssetImage( foto?.path ?? 'assets/no-image.png'),
    //     height: 300.0,
    //     fit: BoxFit.cover,

    //   );

    // }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      entity.eveFoto = null;
    }

    setState(() {});
  }
}
