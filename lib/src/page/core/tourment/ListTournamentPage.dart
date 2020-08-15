import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/page/event/EventLoadPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

import 'TourmentPage.dart';

class ListTournamentPage extends StatefulWidget {
  ListTournamentPage({Key key}) : super(key: key);
  static final String routeName = 'ListTournament';

  @override
  _ListTournamentPageState createState() => _ListTournamentPageState();
}

class _ListTournamentPageState extends State<ListTournamentPage> {
  final prefs = new Preferense();
    final scaffoldKey = GlobalKey<ScaffoldState>();

  ListaTorneoModel entity = new ListaTorneoModel();
  TourmentService entityService;
  TourmentService entityGet = TourmentService();

  @override
  void initState() {
    super.initState();
  }

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
        body: bodyContainer(context),
        drawer: DrawerMenu(),
        bottomNavigationBar: convexAppBar(),
      ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getTodosLosTorneos(new ListaTorneoModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return Column(
                children: <Widget>[
                  Text('Listado de torneos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  divider(),
                  listView(context, snapshot),
                  copyRigth(),
                ],
              );
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        ListaTorneoModel entity = snapshot.data[index];
        return showListTournament(context,entity);
      },
    );
  }

  Widget showListTournament ( BuildContext context, ListaTorneoModel entity) {    
    return InkWell(
      onTap:() {navegation(context ,TourmentPage(idTorneo: entity.idTorneo ));},//  ,
          child: gfListTile(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(entity.nombreTorneo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('Inscritos: 100/${entity.cantidadJugadores}'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Detalle:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              sizedBox(5, 0),
              Text(entity.detalle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Premios:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      sizedBox(5, 0),
                      Text(entity.premios, style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  Text('Estado'),
                ],
              ),
              Text(
                  'Del ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)} al ${new DateFormat.yMMMMd('es_BO').format(entity.fechaFin)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          null, //FaIcon(FontAwesomeIcons.infoCircle),
          avatarCircle(entity.foto, 25.0),
          EdgeInsets.all(10.0),
          EdgeInsets.all(10.0)),
    );
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
