import 'package:auto_size_text/auto_size_text.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/page/event/EventLoadPage.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
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
        appBar: appBar('TORNEOS FIFA BOLIVIA'),
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
                  // Row(
                  //   children: <Widget>[
                  //     Shimmer.fromColors(
                  //       baseColor: AppTheme.themeDefault,
                  //       highlightColor: AppTheme.themePurple,
                  //       child: FaIcon(FontAwesomeIcons.playstation,
                  //           color: AppTheme.themeDefault, size: 35.0),
                  //     ),
                  //     AutoSizeText(
                  //       'Listado de torneos'.toUpperCase(),
                  //       style: kTitleStyleBlack,
                  //       softWrap: true,
                  //       overflow: TextOverflow.clip,
                  //       textAlign: TextAlign.justify,
                  //     ),
                  //   ],
                  // ),

                  sizedBox(0, 8.0),
                  showInformation(
                        context,
                        'LISTADO DE TORNEOS - FIFA BOLIVIA?',
                        'Conoce los resultados.',
                        'Visita Sorojchi eclub en facebook',
                        'INGRESASTE A SORIJCHI ECLUB',
                        'https://www.facebook.com/SorojchieClub/'),
                        sizedBox(0, 5.0),
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
    return Container(
      width: size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          ListaTorneoModel entity = snapshot.data[index];
          return showListTournament(context, entity);
        },
      ),
    );
  }

  Widget showListTournament(BuildContext context, ListaTorneoModel entity) {
     return Container(
      child: InkWell(
        onTap: () {
          navegation(context, TourmentPage(idTorneo: entity.idTorneo));
        },
         child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0.0),
                  decoration: boxDecoration(),
                  child: Column(
                    children: <Widget>[ //  ,
        gfListTile(
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
                AutoSizeText(
                    'Del ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)} al ${new DateFormat.yMMMMd('es_BO').format(entity.fechaFin)}',
                     style: kSubSubTitleCardStyle,
                       softWrap: true,
                        overflow: TextOverflow.clip,
                         textAlign: TextAlign.justify,),
              ],
            ),
            null, //FaIcon(FontAwesomeIcons.infoCircle),
            avatarCircle(entity.foto, 25.0),
            EdgeInsets.all(10.0),
            EdgeInsets.all(10.0)),
            
                    ],
         ),
         ),
      ),
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
