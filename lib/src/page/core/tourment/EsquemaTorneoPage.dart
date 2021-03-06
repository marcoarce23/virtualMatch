import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/FechaEsquemaTorneos.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListaFechasTorneo.dart';
import 'package:virtual_match/src/model/entity/EntityMap/ChangeDate.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class EsquemaTorneoPage extends StatefulWidget {
  final int idTorneo;

  EsquemaTorneoPage({@required this.idTorneo});

  @override
  _EsquemaTorneoPageState createState() => _EsquemaTorneoPageState();
}

class _EsquemaTorneoPageState extends State<EsquemaTorneoPage> {
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TourmentService entityService = new TourmentService();
  TourmentService entityGet = TourmentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('ESQUEMA DEL TORNEO'),
      body: SingleChildScrollView(
          child: Container(child: bodyContainer(context))),
      drawer: DrawerMenu(),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget bodyContainer(BuildContext context) {
    sizedBox(0, 7);
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getFechasEsquemaPartidos(
            new FechaEsquemaTorneos(), widget.idTorneo),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return Column(
                children: <Widget>[
                  sizedBox(0, 10),
                  showInformationBasic(
                    context,
                    'ESQUEMA DE TORNEOS',
                    '',
                  ),
                  sizedBox(0, 5.0),
                  divider(),
                  listView(context, snapshot),
                  //     copyRigthBlack(),
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
          FechaEsquemaTorneos entity = snapshot.data[index];
          return Column(
            children: [
              showEsquemaTorneoPage(context, entity),
              Divider(
                color: Colors.black,
              )
            ],
          );
        },
      ),
    );
  }

  Widget showEsquemaTorneoPage(
      BuildContext context, FechaEsquemaTorneos entity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Grupo / Fase",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            Text(entity.grupo),
            Text(
              "Fecha",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            Text(entity.fecha),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(entity.jugador1),
            Text(entity.jugador2),
          ],
        ),

        //dividerBlack(),
      ],
    );
  }
}
