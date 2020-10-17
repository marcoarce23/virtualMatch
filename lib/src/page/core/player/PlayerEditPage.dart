import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;
import 'package:virtual_match/src/page/core/equipment/EquipmetAllListPage.dart';
import 'package:virtual_match/src/page/core/player/PlayerEquipmentPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardSlideProductWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class PlayerEditPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  PlayerEditPage({Key key}) : super(key: key);

  @override
  _PlayerEditPageState createState() => _PlayerEditPageState();
}

class _PlayerEditPageState extends State<PlayerEditPage> {
  //DEFINICION DE BLOC Y MODEL
  JugadorModelList entity = new JugadorModelList();
  model.JugadorModel entityModel = new model.JugadorModel();
  PlayerService entityGet = PlayerService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = PlayerEditPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('EDITAR PERFIL'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/portada2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              backgroundBasic(context),
              sizedBox(0.0, 8.0),
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    showInformationBasic(
                      context,
                      'EDITA TU PERFIL',
                      'Puedes mejorar tu perfil modifica tus datos.',
                    ),
                    sizedBox(0.0, 2.0),
                  ],
                ),
              ),
              futureBuilder(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      //  ),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getId(new model.JugadorModel(), int.parse(prefs.idPlayer)),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          model.JugadorModel entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(model.JugadorModel entity) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
             sizedBox(0.0, 5.0),
            // Center(
            //   child: Image(
            //     image: NetworkImage(IMAGE_SCREEN3),
            //     height: 180.0,
            //     fit: BoxFit.fill,
            //   ),
            // ),
             CardSlideBalckWidget(),
             sizedBox(0.0, 5.0),
            CardVM(
              size: 330,
              imageAssets: 'assets/icono3.png',
              opciones:
                  _simplePopup(entity, entity.idJugador.toString(), context),
              accesosRapidos: null,
              listWidgets: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    avatarCircle(entity.foto, 55),
                    sizedBox(0, 7),
                    Text(
                      'FIFERO: ${entity.nombre} ${entity.apellido}',
                      style: kSigsTitleStyle,
                    ),
                    sizedBox(0, 7),
                    Text(
                      'IPSDN: ${entity.idPsdn}',
                      style: kSigsTitleStyle,
                    ),
                    sizedBox(0, 7),
                    Text(
                      'Correo: ${entity.correo}',
                      style: kSigsTitleStyle,
                    ),
                    sizedBox(0, 7),
                    Text(
                      'Facebook: ${entity.facebook}',
                      style: kSigsTitleStyle,
                    ),
                    sizedBox(0, 7),
                    Text(
                      'WhatsApp: ${entity.telefono}',
                      style: kSigsTitleStyle,
                    ),
                    sizedBox(0, 7),
                    Text(
                      'Información Complementaria: ${entity.informacionComplementaria}',
                      style: kSigsTitleStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _simplePopup(
          model.JugadorModel entity, String keyId, BuildContext context) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          // PopupMenuItem(
          //   value: 1,
          //   child: Text("Notificar"),
          // ),
          PopupMenuItem(
            value: 1,
            child: Text("Edita tu Perfil"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Crea tu equipo"),
          ),

          PopupMenuItem(
            value: 3,
            child: Text("Incribirse o salirse de un equipo"),
          ),

          PopupMenuItem(
            value: 4,
            child: Text("Sobre mi equipo"),
          ),
        ],
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {
          switch (value) {
            // case 1:
            //   showSnackbarWithOutKey("Por implementar", context);
            //   break;
            case 1:
              Navigator.pushNamed(context, 'playerLoad', arguments: entity);
              break;
            case 2:
              Navigator.pushNamed(context, 'equipment', arguments: entity);
              break;
            case 3:
              navegation(context, EquipmentAllListPage());

              ///api/Equipo/SalirEquipo/{agrupador}/jugador/{idJugador}

              break;
            case 4:
              navegation(context, PlayerEquipmentPage());

              break;
            default:
              showSnackbarWithOutKey("No hay opcion seleccionada", context);
              break;
          }
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        offset: Offset(0, 100),
      );

  // _inscribirse(String keyId, String modalidad) {
  //   _executeGenerator(
  //       '/api/Torneo/execGenerarLiga/' + keyId + '/usuario/' + prefs.email);
  // }

  // _salirse(String keyId, String agrupador) {
  //   _executeGenerator(
  //       '/api/Equipo/SalirEquipo/' + agrupador + '/jugador/' + prefs.idPlayer);
  // }

  // void _executeGenerator(String url) async {
  //   print('EL URLLL: $url}');
  //   try {
  //     // await entityService.execute(API + url).then((result) {
  //     //   if (result["tipo_mensaje"] == '0')
  //     //     showSnackbar(result["mensaje"], scaffoldKey);
  //     //   else
  //     //     showSnackbar(result["mensaje"], scaffoldKey);
  //     // });
  //   } catch (error) {
  //     showSnackbar(
  //         'No puede generar porque aun no se completo la cantidad de jugadores inscritos !!',
  //         scaffoldKey);
  //   }
  // }
}
