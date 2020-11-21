import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/JugadorModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart'
    as model;
import 'package:virtual_match/src/model/entity/EntityMap/JugadorModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/PlayerService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/card/CardSlideProductWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class PlayerPage extends StatefulWidget {
  static final String routeName = 'playerPage';
  PlayerPage({Key key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  //DEFINICION DE BLOC Y MODEL
  JugadorModelList entity = new JugadorModelList();
  PlayerService entityGet = PlayerService();
  List<JugadorModelPersonalizado> listPlayers =
      new List<JugadorModelPersonalizado>();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prefs.lastPage = PlayerPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.themeDefault,
        //toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 16),
        elevation: 2.0,
        title: Text('CONOCE A LA COMUNIDAD', style: kTitleAppBar),
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
                      'CONOCE A NUESTROS JUGADORES',
                      'Busca y comunicate con los jugadores.',
                    ),
                    sizedBox(0.0, 8.0),
                    // Center(
                    //   child: Image(
                    //     image: NetworkImage(IMAGE_SCREEN3),
                    //     height: 180.0,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    CardSlideBalckWidget(),
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
      floatingActionButton: floatButtonImage(Colors.transparent, context,
          FaIcon(FontAwesomeIcons.futbol), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new JugadorModelPersonalizado()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              listPlayers.clear();
              for (var i = 0; i < snapshot.data.length; i++) {
                listPlayers.add(snapshot.data[i] as JugadorModelPersonalizado);
              }
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
          model.JugadorModelPersonalizado entity = snapshot.data[index];

          return _showListTile(entity);
        },
      ),
    );
  }

  Widget _showListTile(model.JugadorModelPersonalizado entity) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            sizedBox(0, 7),
            CardVM(
              size: 120,
              imageAssets: 'assets/icono3.png',
              opciones:
                  avatarCircleTransparent((entity.foto ?? IMAGE_LOGO), 35),
              accesosRapidos: opcionesLlamada(entity),
              listWidgets: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${entity.nombre} ${entity.apellido}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'IPSDN: ${entity.idPsdn}',
                      style: TextStyle(color: AppTheme.themeWhite),
                    ),
                    Text(
                      'Departamento: ${entity.departamento}',
                      style: TextStyle(color: AppTheme.themeWhite),
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

  List<Widget> opcionesLlamada(model.JugadorModelPersonalizado entity) {
    return [
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          callNumber(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.phone, color: Colors.white, size: 27),
      ),
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          sendSMS(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.sms, color: Colors.white, size: 27),
      ),
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          callWhatsApp1(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 27),
      ),
    ];
  }
}

class SearchPlayer extends SearchDelegate {
  List<JugadorModelPersonalizado> list = new List<JugadorModelPersonalizado>();

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
                p.nombre.toUpperCase().startsWith(query.toUpperCase()) ||
                p.idPsdn.toUpperCase().startsWith(query.toUpperCase()) ||
                p.apellido.toUpperCase().startsWith(query.toUpperCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              print(query);
            },
            leading: Image.network(
              (suggestionList[index].foto),
              width: 15,
            ),
            title: Row(
              children: [
                AutoSizeText(
                  suggestionList[index].nombre +
                      ' ' +
                      suggestionList[index].apellido,
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Telefono: " + suggestionList[index].telefono),
                Text("PSDN: " + suggestionList[index].idPsdn),
                dividerBlack()
              ],
            ),
          );
        });
  }
}
