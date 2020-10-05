import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/equipment/EquipmentPlayersTournament.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

import 'HistoricTournament.dart';
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
        appBar: appBar('TORNEOS'),
        body: SingleChildScrollView(child: bodyContainer(context)),
        drawer: DrawerMenu(),
        floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
            FaIcon(FontAwesomeIcons.playstation), HomePage()),
        // bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }

  Widget bodyContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        sizedBox(0, 1),
        futureBuilderTorneo(context),
        sizedBox(0, 5),
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/portada1.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          child: GFTabs(
            tabBarColor: AppTheme.themeDefault,
            indicatorColor: AppTheme.themePurple,
            height: MediaQuery.of(context).size.height * 0.80,
            indicatorWeight: 6.0,
            initialIndex: 0,
            length: 4,
            tabs: <Widget>[
              Tab(
                icon: Image.asset(
                  'assets/icono3.png',
                  //scale: 0.4,
                  width: 30,
                  height: 25,
                ),
                child: Text(
                  "EQUIPOS",
                  style: TextStyle(fontSize: 11),
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icono2.png',
                  //scale: 0.4,
                  width: 30,
                  height: 25,
                ),
                child: Text(
                  "Fixture".toUpperCase(),
                  style: TextStyle(fontSize: 11),
                ),
              ),
              Tab(
                icon: avatarCircle(IMAGE_DEFAULT, 20),
                child: Text(
                  "Posiciones".toUpperCase(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icono3.png',
                  //scale: 0.4,
                  width: 30,
                  height: 25,
                ),
                child: Text(
                  "Historial".toUpperCase(),
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
            tabBarView: GFTabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        dividerBlack(),
                        Shimmer.fromColors(
                          baseColor: AppTheme.themeDefault,
                          highlightColor: AppTheme.themePurple,
                          child: AutoSizeText(
                            'Listado de Equipos'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        sizedBox(0, 0),
                        EquipmentPlayersTournament(
                          idTorneo: widget.idTorneo,
                        ),
                        //copyRigth(),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      dividerBlack(),
                      Shimmer.fromColors(
                        baseColor: AppTheme.themeDefault,
                        highlightColor: AppTheme.themePurple,
                        child: AutoSizeText(
                          'Fixture de Partidos'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TournamentPlayerScored(
                        idTorneo: widget.idTorneo,
                      ),
                      //copyRigth(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      dividerBlack(),
                      Shimmer.fromColors(
                        baseColor: AppTheme.themeDefault,
                        highlightColor: AppTheme.themePurple,
                        child: AutoSizeText(
                          'TABLA DE POSICIONES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PositionTable(
                        idTorneo: widget.idTorneo,
                      ),
                      //copyRigth(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      dividerBlack(),
                      Shimmer.fromColors(
                        baseColor: AppTheme.themeDefault,
                        highlightColor: AppTheme.themePurple,
                        child: AutoSizeText(
                          'Historial de partidos'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sizedBox(0, 0),
                      HistoricTournamentPage(
                        idTorneo: widget.idTorneo,
                      ),
                      //copyRigth(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget futureBuilderTorneo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // sizedBox(0, 10);
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
                                style: TextStyle(color: AppTheme.themeWhite)),
                            Text('DETALLE: ${entity.detalle}',
                                style: TextStyle(color: AppTheme.themeWhite)),
                            Text(
                                'FECHA: ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)} ',
                                style: TextStyle(color: AppTheme.themeWhite)),
                            null,
                            null, //avatarCircle(entity.foto, 45.0),
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
