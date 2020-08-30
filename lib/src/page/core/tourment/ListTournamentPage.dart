import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoTorneoModel.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/menu/CircularMenu.dart';

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
        floatingActionButton: new CircularMenu(),
        bottomNavigationBar: new BottonNavigation(),
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
                 
                       showInformationBasic(
                      context,
                       'LISTADO DE TORNEOS - FIFA BOLIVIA',
                      'Conoce los resultados.',
                    ),
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
            children: <Widget>[
              //  ,
              gfListTile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(entity.nombreTorneo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.themeWhite)),
                      Text('Inscritos: 100/${entity.cantidadJugadores}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Detalle:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.themeWhite)),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13, color: AppTheme.themeWhite)),
                              sizedBox(5, 0),
                              Text(entity.premios,
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          Text('Estado'),
                        ],
                      ),
                      AutoSizeText(
                        'Del ${new DateFormat.yMMMMd('es_BO').format(entity.fechaInicio)}',
                        style: kSubSubTitleCardStyle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                      ),
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
}
