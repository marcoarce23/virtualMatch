import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/event/EventLoadPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/page/login/LogOnPage.dart';
import 'package:virtual_match/src/service/LogInService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferense();
  await prefs.initPrefs();
  runApp(MyApp());

  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final prefs = new Preferense();
  String token;

  @override
  void initState() {
    super.initState();

    //final pushProvider = new PushNotificationProvider();
    // pushProvider.initNotifications();
    // pushProvider.mensajes.listen((data) {
    //   //print('Argumento del Push: $data');

    //   if (data == 'ayudaPersona')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoEmergencia', arguments: data);
    //   else if (data == 'Voluntario')
    //     navigatorKey.currentState
    //         .pushNamed('EncuentraVoluntario', arguments: data);
    //   else if (data == 'organizacion')
    //     navigatorKey.currentState
    //         .pushNamed('ListaInstituciones', arguments: data);
    //   else if (data == 'emergencia')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoEmergencia', arguments: data);
    //   else if (data == 'eventos')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoEventos', arguments: data);
    //   else if (data == 'multimedia')
    //     navigatorKey.currentState
    //         .pushNamed('CiudadanoMultimedia', arguments: data);
    // });
  }

  @override
  Widget build(BuildContext context) {
    Function duringSplash = () {
      int a = 123 + 23;

      if (a > 100)
        return 1;
      else
        return 2;
    };

    Map<int, Widget> option = {1: LogOnPage(), 2: HomePage()};

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => new LoginService()),
      ],
      child: MaterialApp(
          title: TITLE,
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale('es', 'ES'), // Hebrew
          ],
          home: AnimatedSplash(
            imagePath: ASSETS_ICON,
            home: LogOnPage(),
            customFunction: duringSplash,
            duration: 3500,
            type: AnimatedSplashType.BackgroundProcess,
            outputAndHome: option,
          ),

          //   home: ListTournamentPage(),

          //new HomePage(), //MapAdressModule(),

          routes: <String, WidgetBuilder>{
            //        'splash': (BuildContext context) => new SplashPage(),
            'login': (BuildContext context) => new LogOnPage(),
            'event': (BuildContext context) => new EventAllPage(),
            'multimedia': (BuildContext context) => new EventAllPage(),
            'new': (BuildContext context) => new EventAllPage(),
            'notification': (BuildContext context) => new EventAllPage(),
            'organization': (BuildContext context) => new EventAllPage(),
            'player': (BuildContext context) => new EventAllPage(),
            'album': (BuildContext context) => new EventAllPage(),
            'comment': (BuildContext context) => new EventAllPage(),
            'mini': (BuildContext context) => new EventAllPage(),
            'tourment': (BuildContext context) => new EventAllPage(),
            'faq': (BuildContext context) => new EventAllPage(),
            'score': (BuildContext context) => new EventAllPage(),
            'result': (BuildContext context) => new EventAllPage(),
            'ranking': (BuildContext context) => new EventAllPage(),
            'eleven': (BuildContext context) => new EventAllPage(),
            'fixture': (BuildContext context) => new EventAllPage(),
          }),
    );
  }
}
