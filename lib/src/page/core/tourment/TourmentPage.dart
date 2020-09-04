import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentPlayersTournament.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

import 'PositionTable.dart';
import 'TournamentPlayerScored.dart';

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

  TabController tabController;
  
  @override
  void initState() {
     // tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar('TORNEOS FIFA BOLIVIA'),
        body: bodyContainer(context),
        drawer: DrawerMenu(),
        // bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        sizedBox(0, 6),
        futureBuilderTorneo(context),
        sizedBox(0, 8),

       GFSegmentTabs(


  length: 3,
  tabs: <Widget>[
     Tab(
              icon: Icon(Icons.perm_identity),
              child: Text(
                "EQUIPOS",
              ),
            ),
            Tab(
              icon: Icon(Icons.score),
              child: Text(
                "Fixture".toUpperCase(),
              ),
            ),
            Tab(
              icon: Icon(Icons.table_chart),
              child: Text(
                "Posiciones".toUpperCase(),
              ),
            ),
   ],
),

        // GFTabs(
        //   tabBarColor: AppTheme.themeDefault,
        //   indicatorColor: AppTheme.themePurple,
        //   //indicatorWeight: 4.0,
        //   initialIndex: 0,
        //   length: 3,
        //   tabs: <Widget>[
        //     Tab(
        //       icon: Icon(Icons.perm_identity),
        //       child: Text(
        //         "EQUIPOS",
        //       ),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.score),
        //       child: Text(
        //         "Fixture".toUpperCase(),
        //       ),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.table_chart),
        //       child: Text(
        //         "Posiciones".toUpperCase(),
        //       ),
        //     ),
        //   ],
        //   tabBarView: GFTabBarView(
        //     children: <Widget>[
        //       SingleChildScrollView(
        //         child: Column(
        //           children: <Widget>[
        //             divider(),
        //             Text('Listado de Equipos'.toUpperCase(),
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 20)),
        //             sizedBox(0, 6),
        //             EquipmentPlayersTournament(
        //               idTorneo: widget.idTorneo,
        //             ),
        //             //copyRigth(),
        //           ],
        //         ),
        //       ),
        //       SingleChildScrollView(
        //         child: Column(
        //           children: <Widget>[
        //             divider(),
        //             Text('Fixture de Partidos'.toUpperCase(),
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 20)),
        //             TournamentPlayerScored(
        //               idTorneo: widget.idTorneo,
        //             ),
        //             //copyRigth(),
        //           ],
        //         ),
        //       ),
        //       SingleChildScrollView(
        //         child: Column(
        //           children: <Widget>[
        //             divider(),
        //             Text('TABLA DE POSICIONES',
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 20)),
        //             PositionTable(
        //               idTorneo: widget.idTorneo,
        //             ),
        //             //copyRigth(),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget futureBuilderTorneo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    sizedBox(0, 10);
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
                    sizedBox(0, 7),
                    Container(
                      width: size.width * 0.95,
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      decoration: boxDecoration(),
                      child: Column(
                        children: <Widget>[
                          gfListTile(
                            Text('TORNEO: ${entity.nombreTorneo.toUpperCase()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Text('DETALLE: ${entity.detalle}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Text(
                                'FECHA: ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            null,
                            avatarCircle(entity.foto, 45.0),
                            EdgeInsets.all(3),
                            EdgeInsets.all(3),
                          ),
                        ],
                      ),
                    ),
                    //   Text('Estado'),
                  ],
                ),
              );
          }
        });
  }
}
