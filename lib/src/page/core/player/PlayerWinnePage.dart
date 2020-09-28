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
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoGanadores.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/TorneoModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';
import 'package:virtual_match/src/widget/util/Util.dart';
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
      appBar: appBar('GANADORES'),
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
                divider(),
                sizedBox(0.0, 7.0),
                futureBuilder(context),
                sizedBox(0.0, 7.0),
                divider(),
                /*
                WinnerPlayer(
                  nombreTorneo: 'Los gatos rabiosos',
                  url1erGanador:
                      'https://www.mundodeportivo.com/r/GODO/MD/p7/Futbol/Imagenes/2020/04/06/Recortada/img_agomezo_20200326-110529_imagenes_md_otras_fuentes_gettyimages-1205035438-kT0F-U48336284567QyD-980x554@MundoDeportivo-Web.jpg',
                  url2doGanador:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOPxsm3tCsTc24r9WogA7muPB-1OmYBTdkUw&usqp=CAU',
                  url3erGanador:
                      'https://e00-marca.uecdn.es/assets/multimedia/imagenes/2020/08/11/15971300653800.png',
                  nombre1erGanador: 'yo',
                  nombre2doGanador: 'tu',
                  nombre3erGanador: 'el',
                ),
                sizedBox(0, 20),
                WinnerPlayer(
                  nombreTorneo: 'Los gatos maleantes',
                  url1erGanador:
                      'https://depor.com/resizer/B4EsskVwC3irlYgg6xBAs61aWWY=/580x330/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/IKWKVPLMQND27JIB7S4LCSUH3Y.jpg',
                  url2doGanador:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTSco3xb0fQuFLGM8lpGUATudGnJQ_gigu4eA&usqp=CAU',
                  url3erGanador:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTkd8vZYOqIVUFWU76e28q8phQVVrF4WCBlUQ&usqp=CAU',
                  nombre1erGanador: 'yo',
                  nombre2doGanador: 'tu',
                  nombre3erGanador: 'el',
                ),
                WinnerPlayer(
                  nombreTorneo: 'Los gatos maleantes',
                  url1erGanador:
                      'https://depor.com/resizer/B4EsskVwC3irlYgg6xBAs61aWWY=/580x330/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/IKWKVPLMQND27JIB7S4LCSUH3Y.jpg',
                  url2doGanador:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTSco3xb0fQuFLGM8lpGUATudGnJQ_gigu4eA&usqp=CAU',
                  url3erGanador:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTkd8vZYOqIVUFWU76e28q8phQVVrF4WCBlUQ&usqp=CAU',
                  nombre1erGanador: 'yo',
                  nombre2doGanador: 'tu',
                  nombre3erGanador: 'el',
                ),
                */
                copyRigth(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
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
        return Center(
          child: WinnerPlayer(
              nombreTorneo: entity.nombre_torneo,
              url1erGanador: (entity.foto_1 != '') ? entity.foto_1 : IMAGE_LOGO,
              url2doGanador: (entity.foto_2 != '') ? entity.foto_2 : IMAGE_LOGO,
              url3erGanador: (entity.foto_3 != '') ? entity.foto_3 : IMAGE_LOGO,
              nombre1erGanador: entity.jugador_1,
              nombre2doGanador: entity.jugador_2,
              nombre3erGanador: entity.jugador_3),
        );
      },
    );
  }
}
