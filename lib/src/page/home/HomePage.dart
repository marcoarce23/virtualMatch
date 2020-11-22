import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NoticiaEventoModel.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/service/NewService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/bottonNavigationBar/BottonNavigatorWidget.dart';
import 'package:virtual_match/src/widget/card/CardSlideProductWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificacionModel entity = new NotificacionModel();
  NewService entityGet = NewService();
  List<NoticiaEventoModel> listPlayers = new List<NoticiaEventoModel>();
  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();

  File photo;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  int selectedRadio = 18;
  int _group = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget futureBuilderNoticias(BuildContext context, int grupo) {
    return FutureBuilder(
        future: entityGet.get(new NoticiaEventoModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text(".....");
              break;
            default:
              listPlayers.clear();
              for (var i = 0; i < snapshot.data.length; i++) {
                listPlayers.add(snapshot.data[i] as NoticiaEventoModel);
              }
              return listView(grupo, context, snapshot);
          }
        });
  }

  Widget listView(int grupo, BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        NoticiaEventoModel entity = snapshot.data[index];
        String titulo = (entity.tipo == 0 ? 'NOTICIA' : 'EVENTO') +
            "\n${entity.titulo.toUpperCase()}";
        return Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: containerImage2(),
              width: size.width * 0.98,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gfCardAdvanced(
                          context,
                          "Publicado en fecha ${entity.fecha}",
                          titulo,
                          "Dirigido a: ${entity.dirigidoa} \n Descripción: ${entity.dirigidoa}",
                          2,
                          entity.foto),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 25,
              right: 50,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/image/pelota.png',
                  //scale: 0.4,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    prefs.lastPage = HomePage.routeName;

    return SafeArea(
      left: true,
      right: true,
      bottom: true,
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.themeDefault,
          //toolbarOpacity: 0.7,
          iconTheme: IconThemeData(color: AppTheme.themeWhite, size: 16),
          elevation: 2.0,
          title: Text('VIRTUAL MATCH', style: kTitleAppBar),
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
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox(0.0, 5.0),
                // Center(
                //   child: Image(
                //     image: NetworkImage(IMAGE_SCREEN3),
                //     height: 180.0,
                //     fit: BoxFit.fill,
                //   ),
                // ),
                CardSlideBalckWidget(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    //  FaIcon(FontAwesomeIcons.male, color: AppTheme.themeVino),
                    SizedBox(width: 5.0),
                  ],
                ),
                futureBuilderNoticias(context, _group),
                sizedBox(0, 10),
              ],
            ),
          ),
        ),
        drawer: DrawerMenu(),
        bottomNavigationBar: new BottonNavigation(),
      ),
    );
  }
}

class SearchPlayer extends SearchDelegate {
  List<NoticiaEventoModel> list = new List<NoticiaEventoModel>();

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
                p.titulo.toUpperCase().startsWith(query.toUpperCase()) ||
                p.objetivo.toUpperCase().startsWith(query.toUpperCase()) ||
                p.dirigidoa.toUpperCase().startsWith(query.toUpperCase()))
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
                  suggestionList[index].titulo,
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
                Text("Objetivo: " + suggestionList[index].objetivo),
                Text("Dirigido a: " + suggestionList[index].dirigidoa),
                Text((suggestionList[index].tipo == 0 ? 'NOTICIA' : 'EVENTO')),
                dividerBlack()
              ],
            ),
          );
        });
  }
}
