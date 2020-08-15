import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentPlayersTournament.dart';
import 'package:virtual_match/src/page/event/EventLoadPage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class TourmentPage extends StatefulWidget {
  final int idTorneo;

  TourmentPage({Key key, @required this.idTorneo}) : super(key: key);

  @override
  _TourmentPageState createState() => _TourmentPageState();
}

class _TourmentPageState extends State<TourmentPage> {
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ListaTorneoModel entity = new ListaTorneoModel();
  TourmentService entityService;
  TourmentService entityGet = TourmentService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            backgroundColor: AppTheme.themeBlackBlack,
            // toolbarOpacity: 1.0,
            iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 15),
            elevation: 5,
            title: Row(
              children: <Widget>[
                Text(
                  "Virtual Match ",
                  style: kTitleAppBar,
                  textAlign: TextAlign.center,
                ),
                sizedBox(125.0, 0.0),
                FaIcon(
                  FontAwesomeIcons.playstation,
                  color: AppTheme.themeWhite,
                  size: 25,
                ),
              ],
            )),
        body: SingleChildScrollView(child: bodyContainer(context)),
        drawer: DrawerMenu(),
        bottomNavigationBar: convexAppBar(),
      ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    return Column(
      children: <Widget>[
          
        futureBuilderTorneo(context),       
        copyRigth(),
      ],
    ); //futureBuilder(context);
  }

  Widget futureBuilderTorneo(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getId(new ListaTorneoModel(), widget.idTorneo),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              ListaTorneoModel entity = snapshot.data[0];
              return Center(
                child: Column(                  
                  children: <Widget>[
                    avatarCircle(entity.foto, 55.0),
                    Text(entity.nombreTorneo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(entity.detalle),
                  Text(
                  'Del ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)} al ${new DateFormat.yMMMMd('es_BO').format(entity.fechaFin)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                     Text('Estado'),
                     divider(),
                     Text('Listado de Equipos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                     EquipmentPlayersTournament(idTorneo:entity.idTorneo ,),
                  ],
                ),
              );
          }
        });
  }

  Widget convexAppBar() {
    return ConvexAppBar.badge(
      {0: '99+', 1: Icons.assistant_photo, 2: Colors.redAccent},

      backgroundColor: AppTheme.themeDefault,
      style: TabStyle.reactCircle,
      elevation: 3.0,
      items: [
        TabItem(icon: Icons.next_week, title: 'Noticias'),
        TabItem(icon: Icons.event_available, title: 'Evento'),
        TabItem(icon: Icons.add, title: 'Torneo', isIconBlend: true),
        TabItem(icon: Icons.gamepad, title: 'Jugadores'),
        TabItem(icon: Icons.notifications_active, title: 'Notific'),
      ],
      initialActiveIndex: 2, //optional, default as 0
      onTap: (value) {
        setState(() {
          if (value == 0) navegation(context, EventAllPage());
          if (value == 1) navegation(context, EventAllPage());
          if (value == 2) navegation(context, EventAllPage());
          if (value == 3) navegation(context, EventAllPage());
          if (value == 4) navegation(context, EventAllPage());
        });
      },
    );
  }
}
