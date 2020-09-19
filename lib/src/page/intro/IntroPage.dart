import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';

import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class IntroPage extends StatefulWidget {
  static final String routeName = 'IntroPage';
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final prefs = new Preferense();
  final int _numPages = 3;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    prefs.lastPage = IntroPage.routeName;
    super.initState();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.themeDefault : AppTheme.themePurple,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //    backgroundBasic(context),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => navegation(
                      context,
                      HomePage(),
                    ),
                    child: Text(
                      'Iniciar',
                      style: TextStyle(
                        color: AppTheme.themeDefault,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/vm_quienessomos.png',
                                //scale: 0.4,
                                height: 150.0,
                                fit: BoxFit.fill,
                              ),

                              // Image(
                              //   image: NetworkImage(IMAGE_ORGANIZATION),
                              //   height: 180.0,
                              //   fit: BoxFit.fill,
                              // ),
                            ),

                            Shimmer.fromColors(
                              baseColor: AppTheme.themeDefault,
                              highlightColor: AppTheme.themePurple,
                              child: AutoSizeText(
                                'Somos la comunidad más grande de fútbol virtual de Bolivia',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            sizedBox(0, 15.0),
                            //    Expanded(
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 20.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeDefault,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child:
                                    avatarCircle(IMAGE_LOGOB, 25.0),
                                    //  ),
                                    sizedBox(10, 15.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Organizamos los torneos más competitivos de fútbol virtual del país.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox(0, 15.0),
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 15.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeDefault,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeDefault,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_DEFAULT, 25.0),
                                    sizedBox(10, 15.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Te mantenemos informado de todos los campeonatos de la comunidad .',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox(0, 11.0),
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 11.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeDefault,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeDefault,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_LOGOB, 25.0),
                                    sizedBox(10, 10.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Impulsamos la competitividad y el entretenimiento. Crea tus propios torneos y realiza campeonatos personalizados con  tus amig@s',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //  ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/vm_queofrecemos.png',
                                //scale: 0.4,
                                height: 150.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            sizedBox(0, 10.0),
                            Shimmer.fromColors(
                              baseColor: AppTheme.themeDefault,
                              highlightColor: AppTheme.themePurple,
                              child: AutoSizeText(
                                'Qué ofrecemos',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            sizedBox(0, 10.0),

                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 10.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeDefault,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeDefault,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_DEFAULT, 25.0),
                                    sizedBox(10, 10.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Reunir a la mayor cantidad de FIFEROS de Bolivia, consolidando la comunidad de FIFA. ',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox(0, 10.0),
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 10),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeDefault,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeDefault,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_LOGOB, 25.0),
                                    sizedBox(10, 10.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Medir tus habilidades contra los mejores FIFEROS de nacionales e internacionales de Bolivia.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox(0, 11.0),
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 10.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeDefault,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeDefault,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_DEFAULT, 25.0),
                                    sizedBox(10, 10.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'La posibilidad de ganar grandes premios por divertirte y hacer lo que más te gusta.',
                                        style: kSubtitleStyleBlack,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: NetworkImage(IMAGE_SCREEN3),
                                height: 180.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            sizedBox(0, 5.0),
                            Shimmer.fromColors(
                              baseColor: AppTheme.themeDefault,
                              highlightColor: AppTheme.themePurple,
                              child: AutoSizeText(
                                'Qué buscamos en la Comunidad.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            sizedBox(0, 12.0),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      sizedBox(0, 10.0),
                                      // Shimmer.fromColors(
                                      //   baseColor: AppTheme.themeDefault,
                                      //   highlightColor: AppTheme.themePurple,
                                      //   child: FaIcon(
                                      //       FontAwesomeIcons.playstation,
                                      //       color: AppTheme.themeDefault,
                                      //       size: 35.0),
                                      // ),
                                      avatarCircle(IMAGE_LOGOB, 25.0),
                                      sizedBox(10.0, 0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Impulsar y promover a nuevos talentos bolivianos del futbol virtual.',
                                          style: kSubtitleStyleBlack,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox(0, 12.0),
                                  Row(
                                    children: <Widget>[
                                      sizedBox(0, 10.0),
                                      // Shimmer.fromColors(
                                      //   baseColor: AppTheme.themeDefault,
                                      //   highlightColor: AppTheme.themePurple,
                                      //   child: FaIcon(
                                      //       FontAwesomeIcons.playstation,
                                      //       color: AppTheme.themeDefault,
                                      //       size: 35.0),
                                      // ),
                                      avatarCircle(IMAGE_DEFAULT, 25.0),
                                      sizedBox(10, 10.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Competir con nuestros represantes nacioanle se internacionales para medir tus habilidades.',
                                          style: kSubtitleStyleBlack,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox(0, 12.0),
                                  Row(
                                    children: <Widget>[
                                      sizedBox(0, 10.0),
                                      // Shimmer.fromColors(
                                      //   baseColor: AppTheme.themeDefault,
                                      //   highlightColor: AppTheme.themePurple,
                                      //   child: FaIcon(
                                      //       FontAwesomeIcons.playstation,
                                      //       color: AppTheme.themeDefault,
                                      //       size: 35.0),
                                      // ),
                                      avatarCircle(IMAGE_LOGOB, 25.0),
                                      sizedBox(10, 10.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Creamos puentes de integración a través de la diversión y el entretenimiento sano.',
                                          style: kSubtitleStyleBlack,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: AppTheme.themeDefault,
                                    fontSize: 22.0,
                                  ),
                                ),
                                sizedBox(0, 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppTheme.themeDefault,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 50.0,
              width: double.infinity,
              color: Colors.white54,
              child: GestureDetector(
                onTap: () => navegation(
                  context,
                  HomePage(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Comenzar',
                          style: TextStyle(
                            color: AppTheme.themeDefault,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sizedBox(10.0, 0),
                        avatarCircle(IMAGE_LOGOB, 15),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
