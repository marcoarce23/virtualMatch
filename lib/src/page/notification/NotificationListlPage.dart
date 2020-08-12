import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';

class NotificationListPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  NotificationListPage({Key key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  //DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  NotificationService entityService;
  NotificationService entityGet = NotificationService();

  // DEFINICIOND E VARIABLES
  final prefs = new Preferense();

  @override
  void initState() {
    prefs.lastPage = NotificationListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   // entityService = Provider.of<NotificationService>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    gfListTileText(
                        'NOTIFICACIÓN: Virtual Match',
                        'Porque formas parte de la familia, te tenemos informado.',
                        FaIcon(FontAwesomeIcons.infoCircle),
                        avatarSquare(IMAGE_DEFAULT, 35.0),
                        EdgeInsets.all(5.0),
                        EdgeInsets.all(3.0)),
                  ],
                ),
              ),
              divider(),
              sizedBox(0.0, 7.0),
              futureBuilder(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
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
                    gfListTileText(
                        entity.titulo.toUpperCase(),
                        entity.titulo,
                        FaIcon(FontAwesomeIcons.playstation),
                        avatarCircle(IMAGE_LOGO, 35.0),
                        EdgeInsets.all(5.0),
                        EdgeInsets.all(3.0)),
                    // ListTile(
                    //   leading: avatarCircle(IMAGE_LOGO, 35.0),
                    //   title: listItem(context, entity),
                    // ),
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

  // Widget listItem(BuildContext context, NotificacionModel entity) {
  //   return Wrap(
  //     children: <Widget>[
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Container(
  //               width: MediaQuery.of(context).size.width - 110,
  //               child: Row(
  //                 children: <Widget>[
  //                   Icon(
  //                     Icons.person,
  //                     color: AppTheme.themeDefault,
  //                     size: 15,
  //                   ),
  //                   Text('${entity.titulo}', style: kSubTitleCardStyle),
  //                 ],
  //               )),
  //           Container(
  //               child: Row(
  //             children: <Widget>[
  //               Icon(
  //                 Icons.phone_android,
  //                 color: AppTheme.themeDefault,
  //                 size: 15,
  //               ),
  //               Text(
  //                 '${entity.titulo}',
  //                 style: kSubSubTitleCardStyle,
  //               ),
  //             ],
  //           )),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
