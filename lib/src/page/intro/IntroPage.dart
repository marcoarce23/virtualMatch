import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';

import 'package:virtual_match/src/theme/Theme.dart';
import 'package:page_transition/page_transition.dart';

class IntroPage extends StatefulWidget {
  static final String routeName = 'IntroPage';
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  //  final prefs = new PreferensUser();
  final int _numPages = 3;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    //  prefs.ultimaPagina = IntroPage.routeName;
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
        color: isActive ? AppTheme.themeDefault : Colors.black54,
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
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     // begin: Alignment.topCenter,
          //     // end: Alignment.bottomRight,
          //     // stops: [0.1, 0.4, 0.7, 0.9],
          //     colors: [
          //       Colors.white,
          //       Colors.white,
          //       Colors.white,
          //       Colors.white,
          //     ],
          //   ),
          // ),
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
                        fontSize: 22.0,
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
                                  image: AssetImage(
                                    'assets/impulse01.jpg',
                                  ),
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              ),
                              AutoSizeText(
                                'virtual_match, es una APP social para los voluntarios.',
                                style: kSubtitleStyleBlack,
                                maxLines: 2,
                                minFontSize: 15.0,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 15.0),
                              //    Expanded(
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 11.0),
                                      FaIcon(
                                          FontAwesomeIcons.handHoldingMedical,
                                          color: AppTheme.themeDefault,
                                          size: 35.0),
                                      SizedBox(width: 11.0),
                                      Expanded(
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.red,
                                          highlightColor: Colors.yellow,
                                          child: Text(
                                            'Shimmesdsdsdsdr',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        // AutoSizeText(
                                        //   'Para todas las personas que requieren de una ayuda médica gratuita y virtual.',
                                        //   style: kSubtitleStyleBlack,
                                        //   softWrap: true,
                                        //   overflow: TextOverflow.clip,
                                        //   textAlign: TextAlign.justify,
                                        // ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 11.0),
                                      FaIcon(FontAwesomeIcons.handHoldingHeart,
                                          color: AppTheme.themeDefault,
                                          size: 35.0),
                                      SizedBox(width: 11.0),
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
                                  SizedBox(height: 11.0),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 11.0),
                                      FaIcon(FontAwesomeIcons.handHoldingWater,
                                          color: AppTheme.themeDefault,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/impulse02.jpg',
                                  ),
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              AutoSizeText(
                                'QUIENES FORMAN PARTE ?',
                                style: kTitleStyleBlack,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 13.0),
                              //    Expanded(
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 10.0),
                                      FaIcon(FontAwesomeIcons.peopleCarry,
                                          color: AppTheme.themeDefault,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
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
                                  SizedBox(height: 13.0),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 10.0),
                                      FaIcon(FontAwesomeIcons.peopleArrows,
                                          color: AppTheme.themeDefault,
                                          size: 35.0),
                                      SizedBox(width: 13.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'Grupo de personas que te brindan apoyo gratuito y virtual e interesad@s en brindarte material de apoyo y eventos para tu aprendizaje.',
                                          style: kSubtitleStyleBlack,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 13.0),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 10.0),
                                      FaIcon(FontAwesomeIcons.diagnoses,
                                          color: AppTheme.themeDefault,
                                          size: 35.0),
                                      SizedBox(width: 10.0),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  colorBlendMode: BlendMode.darken,
                                  gaplessPlayback: true,
                                  fit: BoxFit.scaleDown,
                                  filterQuality: FilterQuality.high,
                                  image: AssetImage(
                                    'assets/impulse03.jpg',
                                  ),
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    'SOLO TE RECOMENDAMOS.',
                                    style: kTitleStyleBlack,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 10.0),
                                        FaIcon(FontAwesomeIcons.firstAid,
                                            color: AppTheme.themeDefault,
                                            size: 30.0),
                                        SizedBox(width: 10.0),
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
                                    SizedBox(height: 12.0),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 10.0),
                                        FaIcon(FontAwesomeIcons.listUl,
                                            color: AppTheme.themeDefault,
                                            size: 30.0),
                                        SizedBox(width: 10.0),
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
                                    SizedBox(height: 12.0),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 10.0),
                                        FaIcon(FontAwesomeIcons.users,
                                            color: AppTheme.themeDefault,
                                            size: 30.0),
                                        SizedBox(width: 10.0),
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
                                    // SizedBox(height: 12.0),
                                    // Row(
                                    //   children: <Widget>[
                                    //     SizedBox(width: 10.0),
                                    //     FaIcon(FontAwesomeIcons.diagnoses,
                                    //         color: AppTheme.themeDefault,
                                    //         size: 35.0),
                                    //     SizedBox(width: 10.0),
                                    //     Expanded(
                                    //       child: AutoSizeText(
                                    //         'COnisderar que el trabajo de la gente es de voluntariado en funcion........',
                                    //         style: kSubtitleStyleBlack,
                                    //         softWrap: true,
                                    //         overflow: TextOverflow.clip,
                                    //         textAlign: TextAlign.justify,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
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
                                SizedBox(width: 10.0),
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
                          FontAwesomeIcons.playstation,
                          color: AppTheme.themeDefault,
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
