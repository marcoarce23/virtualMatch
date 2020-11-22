import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoModel.dart';
import 'package:virtual_match/src/page/core/player/PlayerWinnePage.dart';
import 'package:virtual_match/src/page/core/tourment/PositionTable.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

class PlayerScoredWinnePage extends StatefulWidget {
  static final String routeName = 'winner';
  int idTorneo;

  PlayerScoredWinnePage(int id) {
    this.idTorneo = id;
  }

  @override
  _PlayerScoredWinnePageState createState() => _PlayerScoredWinnePageState();
}

class _PlayerScoredWinnePageState extends State<PlayerScoredWinnePage> {
  //DEFINICION DE BLOC Y MODEL
  TorneoModel entity = new TorneoModel();
  TourmentService entityService;
  TourmentService entityGet = TourmentService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();

  @override
  void initState() {
    prefs.lastPage = PlayerScoredWinnePage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NotificationService>(context);
    return Scaffold(
      appBar: appBar('SCORED DE GANADORES'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                backgroundBasic(context),
                Container(
                  width: size.width * 0.95,
                  margin: EdgeInsets.symmetric(vertical: 0.0),
                  // decoration: boxDecoration(),
                  child: Column(
                    children: <Widget>[
                      sizedBox(0, 10),
                      showInformationBasic(
                        context,
                        'TE PRESENTAMOS A NUESTROS GANADORES',
                        'Puedes participar y opinar sobre nuestros ganadores.',
                      ),
                    ],
                  ),
                ),
                sizedBox(0.0, 10.0),
                Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/portada1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: PositionTable(
                    idTorneo: widget.idTorneo,
                  ),
                ),
                sizedBox(0.0, 10.0),
                copyRigth(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.arrowLeft), PlayerWinnerPage()),
    );
  }
}
