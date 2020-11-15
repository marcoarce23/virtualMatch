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

class OnceVsOncePage extends StatefulWidget {
  OnceVsOncePage({Key key}) : super(key: key);

  @override
  _OnceVsOncePageState createState() => _OnceVsOncePageState();
}

class _OnceVsOncePageState extends State<OnceVsOncePage> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('11 VS. 11'),
      drawer: DrawerMenu(),
      floatingActionButton: floatButtonImage(Colors.transparent, context,
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
            height: MediaQuery.of(context).size.height,
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
                  "Crear",
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
                  "Asignar",
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
                  "Inscribir",
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
                          'CREAR 11 VS. 11'.toUpperCase(),
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
                        'La Comunidad Virtual Match, te traerá 11 VS. 11.',
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
                          'ASIGNAR 11 VS. 11'.toUpperCase(),
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
                        'La Comunidad Virtual Match, te traerá asignación 11 vs. 11.',
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
                          'Generar 11 vs. 11',
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
                        'La Comunidad Virtual Match, te traerá 11 vs. 11.',
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
