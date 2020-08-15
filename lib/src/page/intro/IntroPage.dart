import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';

import 'package:virtual_match/src/theme/Theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

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
                    onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.bounceOut,
                          type: PageTransitionType.rotate,
                          alignment: Alignment.topCenter,
                          child: HomePage(),
                        )),
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
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: NetworkImage(IMAGE_ORGANIZATION),
                                  height: 180.0,
                                  fit: BoxFit.fill,
                                ),
                              ),

                              Shimmer.fromColors(
                                baseColor: AppTheme.themeDefault,
                                highlightColor: AppTheme.themePurple,
                                child: AutoSizeText(
                                  'Virtual Match es la más grande Comunidad de FIFA.',
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
                                      sizedBox(0, 11.0),
                                      Shimmer.fromColors(
                                        baseColor: AppTheme.themeDefault,
                                        highlightColor: AppTheme.themePurple,
                                        child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            color: AppTheme.themeDefault,
                                            size: 35.0),
                                      ),
                                      sizedBox(0, 11.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Una alternativa para recibir asistencia telefónica, on-line o audiovisual gratuita y virtual.',
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
                                      sizedBox(0, 11.0),
                                      Shimmer.fromColors(
                                        baseColor: AppTheme.themeDefault,
                                        highlightColor: AppTheme.themePurple,
                                        child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            color: AppTheme.themeDefault,
                                            size: 35.0),
                                      ),
                                      sizedBox(0, 11.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Una alternativa para recibir asistencia telefónica, on-line o audiovisual gratuita y virtual.',
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
                                      Shimmer.fromColors(
                                        baseColor: AppTheme.themeDefault,
                                        highlightColor: AppTheme.themePurple,
                                        child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            color: AppTheme.themeDefault,
                                            size: 35.0),
                                      ),
                                      sizedBox(0, 10.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Es un lugar donde podras encontrar material multimedia y eventos del voluntariado para tu aprendizaje.',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: NetworkImage(IMAGE_SCREEN2),
                                  height: 180.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              sizedBox(0, 10.0),
                              Shimmer.fromColors(
                                baseColor: AppTheme.themeDefault,
                                highlightColor: AppTheme.themePurple,
                                child: AutoSizeText(
                                  'Vrtual Match es la más grande Comunidad de FIFA.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
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
                                      Shimmer.fromColors(
                                        baseColor: AppTheme.themeDefault,
                                        highlightColor: AppTheme.themePurple,
                                        child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            color: AppTheme.themeDefault,
                                            size: 35.0),
                                      ),
                                      sizedBox(0, 10.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Grupo de personas que de forma voluntaria y dedicación brindan apoyo a las personas que estan buscando ayuda gratuita y virtual.',
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
                                      sizedBox(10.0, 0),
                                      Shimmer.fromColors(
                                        baseColor: AppTheme.themeDefault,
                                        highlightColor: AppTheme.themePurple,
                                        child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            color: AppTheme.themeDefault,
                                            size: 35.0),
                                      ),
                                      sizedBox(0, 10.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Grupo111 de personas que te brindan apoyo gratuito y virtual e interesad@s en brindarte material de apoyo y eventos para tu aprendizaje.',
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
                                      Shimmer.fromColors(
                                        baseColor: AppTheme.themeDefault,
                                        highlightColor: AppTheme.themePurple,
                                        child: FaIcon(
                                            FontAwesomeIcons.playstation,
                                            color: AppTheme.themeDefault,
                                            size: 35.0),
                                      ),
                                      sizedBox(0, 10.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Grupo de ciudadanos bolivianos que convecidos con nuestro trabajo podemos hacer a diferencia en tu vida.',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Flexible(
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
                                  'Vrtual Match es la más grande Comunidad de FIFA.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
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
                                        Shimmer.fromColors(
                                          baseColor: AppTheme.themeDefault,
                                          highlightColor: AppTheme.themePurple,
                                          child: FaIcon(
                                              FontAwesomeIcons.playstation,
                                              color: AppTheme.themeDefault,
                                              size: 35.0),
                                        ),
                                        sizedBox(10.0, 0),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Hacer buen uso de la aplicación, en tu tiempo y cuando lo necesites.',
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
                                        Shimmer.fromColors(
                                          baseColor: AppTheme.themeDefault,
                                          highlightColor: AppTheme.themePurple,
                                          child: FaIcon(
                                              FontAwesomeIcons.playstation,
                                              color: AppTheme.themeDefault,
                                              size: 35.0),
                                        ),
                                        sizedBox(0, 10.0),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Brindar información real y veridica a las personas con las que te comuniques a través de la APP SomosUnoBolivia.',
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
                                        Shimmer.fromColors(
                                          baseColor: AppTheme.themeDefault,
                                          highlightColor: AppTheme.themePurple,
                                          child: FaIcon(
                                              FontAwesomeIcons.playstation,
                                              color: AppTheme.themeDefault,
                                              size: 35.0),
                                        ),
                                        sizedBox(0, 10.0),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Comparte la aplicación con tus amig@s, familiares y personas para que podamos llegar a más familias bolvianas.',
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
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.bounceOut,
                      type: PageTransitionType.rotate,
                      alignment: Alignment.topCenter,
                      child: HomePage(),
                    )),
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
                        SizedBox(width: 10.0),
                        FaIcon(
                          FontAwesomeIcons.futbol,
                          color: AppTheme.themePurple,
                          size: 18,
                        ),
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
