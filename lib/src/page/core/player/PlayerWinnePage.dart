import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoGanadores.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/core/player/PlayerScoredWinnePage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/winner/WinnerPlayer.dart';

class PlayerWinnerPage extends StatefulWidget {
  static final String routeName = 'winner';
  PlayerWinnerPage({Key key}) : super(key: key);

  @override
  _PlayerWinnerPageState createState() => _PlayerWinnerPageState();
}

class _PlayerWinnerPageState extends State<PlayerWinnerPage> {
  //DEFINICION DE BLOC Y MODEL
  TorneoModel entity = new TorneoModel();
  TourmentService entityService;
  TourmentService entityGet = TourmentService();
  List<ListadoGanadores> listPlayers = new List<ListadoGanadores>();
  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();

  @override
  void initState() {
    prefs.lastPage = PlayerWinnerPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // entityService = Provider.of<NotificationService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeDefault,
        //toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 16),
        elevation: 2.0,
        title: Text('GANADORES', style: kTitleAppBar),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchPlayer(list: listPlayers));
              }),

          avatarCircleDefault(IMAGE_DEFAULT, 31.0),
          //  FaIcon(
          //     FontAwesomeIcons.edit,
          //     color: AppTheme.themePurple,
          //     size: 23,
          //   ),
        ],
      ),
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
                futureBuilder(context),
                sizedBox(0.0, 10.0),
                copyRigth(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: floatButtonImage(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getGanadores(new ListadoGanadores()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              listPlayers.clear();
              for (var i = 0; i < snapshot.data.length; i++) {
                listPlayers.add(snapshot.data[i] as ListadoGanadores);
              }
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        ListadoGanadores entity = snapshot.data[index];
        return Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  navegation(context, PlayerScoredWinnePage(entity.idtorneo));
                },
                child: WinnerPlayer(
                    nombreTorneo: "Torneo:: ${entity.nombre_torneo}",
                    url1erGanador:
                        (entity.foto_1 != '') ? entity.foto_1 : IMAGE_LOGO,
                    url2doGanador:
                        (entity.foto_2 != '') ? entity.foto_2 : IMAGE_LOGO,
                    url3erGanador:
                        (entity.foto_3 != '') ? entity.foto_3 : IMAGE_LOGO,
                    nombre1erGanador: entity.jugador_1,
                    nombre2doGanador: entity.jugador_2,
                    nombre3erGanador: entity.jugador_3),
              ),
            ),
            divider(),
          ],
        );
      },
    );
  }
}

class SearchPlayer extends SearchDelegate {
  List<ListadoGanadores> list = new List<ListadoGanadores>();

  SearchPlayer({this.list});

  String selectResult;
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? list
        : list
            .where((p) =>
                p.nombre_torneo.toUpperCase().startsWith(query.toUpperCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              navegation(context,
                  PlayerScoredWinnePage(suggestionList[index].idtorneo));
            },
            title: Row(
              children: [
                AutoSizeText(
                  suggestionList[index].nombre_torneo,
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                )
              ],
            ),
          );
        });
  }
}
