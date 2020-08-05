import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/event/EventLoadPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_match/src/page/intro/SplashPage.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => new LoginService()),
      ],
      child: MaterialApp(
          title: 'Material App',
          //  theme: miTema,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale('es', 'ES'), // Hebrew
          ],

          // initialRoute: prefs.ultimaPagina,
          home: new LogOnPage(), //MapAdressModule(),

          routes: <String, WidgetBuilder>{
            'splash': (BuildContext context) => new SplashPage(),
            'login': (BuildContext context) => new LogOnPage(),
            'event': (BuildContext context) => new EventAllPage(),
          }),
    );
  }
}
