import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';
import 'package:getwidget/components/tabs/gf_tabs.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

class SocialPage extends StatefulWidget {
  SocialPage({Key key}) : super(key: key);

  @override
  _SocialPagePageState createState() => _SocialPagePageState();
}

class _SocialPagePageState extends State<SocialPage> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('AYUDA SOCIAL'),
      drawer: DrawerMenu(),
      floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
      body: SingleChildScrollView(child: bodyContainer(context)),
    );
  }

  Widget bodyContainer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizedBox(0, 10),
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/portada2.png'),
              fit: BoxFit.cover,
              repeat: ImageRepeat.repeat,
            ),
          ),
         // width: MediaQuery.of(context).size.width * 0.98,
          child: GFTabs(
            tabBarColor: AppTheme.themeDefault,
            indicatorColor: AppTheme.themePurple,
            height: MediaQuery.of(context).size.height ,
            indicatorWeight: 5.0,
            initialIndex: 0,
            length: 3,
            tabs: <Widget>[
              Tab(
                icon: Image.asset(
                  'assets/icono3.png',
                  //scale: 0.4,
                  width: 35,
                  height: 35,
                ),
                child: Text(
                  "Clases FIFA",
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/escudo.png',
                  //scale: 0.4,
                  width: 35,
                  height: 35,
                ),
                child: Text(
                  "Comunidad",
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icono2.png',
                  //scale: 0.4,
                  width: 35,
                  height: 35,
                ),
                child: Text(
                  "Ayuda social",
                ),
              ),
            ],
            tabBarView: GFTabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      divider(),
                      Shimmer.fromColors(
                        baseColor: AppTheme.themeWhite,
                        highlightColor: AppTheme.themePurple,
                        child: AutoSizeText(
                          'CLASES FIFA'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sizedBox(0, 15),
                      showInformationBasic(
                        context,
                        'MUY PRONTO...',
                        'La Comunidad Virtual Match, te traerá nuevas sorpresas.',
                      ),
                      copyRigth(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      divider(),
                      Shimmer.fromColors(
                        baseColor: AppTheme.themeWhite,
                        highlightColor: AppTheme.themePurple,
                        child: AutoSizeText(
                          'LA COMUNIDAD VM'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sizedBox(0, 15),
                      showInformationBasic(
                        context,
                        'MUY PRONTO...',
                        'La Comunidad Virtual Match, te traerá nuevas sorpresas.',
                      ),
                      copyRigth(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      divider(),
                      Shimmer.fromColors(
                        baseColor: AppTheme.themeWhite,
                        highlightColor: AppTheme.themePurple,
                        child: AutoSizeText(
                          'AYUDA SOCIAL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sizedBox(0, 15),
                      showInformationBasic(
                        context,
                        'MUY PRONTO...',
                        'La Comunidad Virtual Match, te traerá nuevas sorpresas.',
                      ),
                      copyRigth(),
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
}
