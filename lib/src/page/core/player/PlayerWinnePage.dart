import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';

class PlayerWinnerPage extends StatefulWidget {
  static final String routeName = 'winner';
  PlayerWinnerPage({Key key}) : super(key: key);

  @override
  _PlayerWinnerPageState createState() => _PlayerWinnerPageState();
}

class _PlayerWinnerPageState extends State<PlayerWinnerPage> {
  //DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  NotificationService entityService;
  NotificationService entityGet = NotificationService();

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
      //    appBar: appBar('COMUNIDAD 24/7.'),
      drawer: DrawerMenu(),
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              divider(),
              sizedBox(0.0, 7.0),
         //     futureBuilder(context),


         GFCard(
    boxFit: BoxFit.cover,
    image: Image.asset('assets/impulse02.jpg'),
    title: GFListTile(
        avatar:GFAvatar(),
        title: Text('Marcelod e la Cruz - RAnking '),
        icon: GFIconButton(
            onPressed: null,
            icon: Icon(Icons.favorite_border),
            type: GFButtonType.transparent,
         )
     ),
     content:Text( "Marcelo de la Cruz - Equipo: Barceona Futbola club"),
     buttonBar: GFButtonBar(
     alignment: WrapAlignment.start,
      children: <Widget>[
        GFButton(
          onPressed: () {},
          text: 'Opina sobre ',
         ),
       ],
     ),
   ),
   
              copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new NotificacionModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          NotificacionModel entity = snapshot.data[index];

          return Column(
            children: <Widget>[
              Container(
                width: size.width * 0.95,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: boxDecoration(),
                child: Column(
                  children: <Widget>[
                    gfListTileKey(
                        Key(entity.idNotificacion.toString()),
                        Text(
                          'TÍTULO : ${entity.titulo}',
                          style: TextStyle(
                            color: AppTheme.themeWhite,
                          ),
                        ),
                        Text('DETALLE: ${entity.detalle}',
                            style: TextStyle(color: AppTheme.themeWhite)),
                        null,
                        null,
                        avatarCircle((entity.foto ?? IMAGE_LOGO), 35),
                        EdgeInsets.all(5.0),
                        EdgeInsets.all(3.0)),
                  ],
                ),
              ),
              sizedBox(0.0, 8.0),
            ],
          );
        },
      ),
    );
  }
}

class GFType {
}


