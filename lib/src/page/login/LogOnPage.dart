import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/page/login/LoginClipperPage.dart';
import 'package:virtual_match/src/service/LogInService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class LogOnPage extends StatefulWidget {
  @override
  _LogOnPageState createState() => _LogOnPageState();
}

class _LogOnPageState extends State<LogOnPage> {
  LoginService loginService;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();
  //LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  String result2;
  var result;
  var result1;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  GoogleSignInAccount currentUser;
  get respuesta => null;

  @override
  void initState() {
    super.initState();
    // prefs.lastPage = LoginPage.routeName;
    initPlatformState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> initPlatformState() async {
    String platformImei = 'Failed to get platform version.';
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      idunique = await ImeiPlugin.getId();
    } catch (exception) {
      showSnackbar('Se produjo un error. $exception', scaffoldKey);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }

  @override
  Widget build(BuildContext context) {
    loginService = Provider.of<LoginService>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Stack(
          children: [
            Container(),
            Image.asset(
              "assets/image/babycare1.jpg",
              fit: BoxFit.cover,
              height: size.height * 0.70,
              width: size.width,
            ),
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: LoginCustomClipper(),
                child: _buttonsSignUp(size, context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buttonsSignUp(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80),
      height: size.height * 0.5,
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: AppTheme.themeDefault,
            highlightColor: AppTheme.themePurple,
            child: AutoSizeText(
              'Bienvenido a Virtual Match',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _gmailButton(),
          _button(context, 'Virtual Match', 18.0, 20.0),
          _crearAcciones(context),
          sizedBox(0.0, 8.0),
          _egree(context),
          copyRigth(),
        ],
      ),
    );
  }

  Future<void> handleSignIn() async {
    try {
      //  await _crearInformacion();
      await _googleSignIn.signIn().then((value) {
        _crearInformacion();
      });
    } catch (error) {
      //showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);

      print('erro: logeo: ${error.toString()} ');
    }
  }

  _crearInformacion() async {
    await _googleSignIn.signIn().then((value) {
      prefs.avatarImage = currentUser.photoUrl;
      prefs.nameUser = currentUser.displayName;
      prefs.email = currentUser.email;

      print('Se ha  logueado ${currentUser.email}');
      print('Se ha  displayName ${currentUser.displayName}');
      print('Se ha  imeie $_platformImei');

      // final dataMap1 = generic.getAll(
      //     entity, getLogin + '${currentUser.email}', primaryKeyGetLogin);

      // dataMap1.then((value) {
      //   //print('SE SETEOOOO 1111');
      //   if (value.length > 0) {
      //     //print('SE SETEOOOO 222');
      //     for (int i = 0; i < value.length; i++) {
      //       entity = value[i];
      //       //print('SE SETEOOOO 333');
      //     }

      //       //print('SE SETEOOOO 444 ${entity.idCreacionInstitucion}');
      //       prefs.imei = _platformImei;
      //       prefs.nombreUsuario = entity.nombrePersona;
      //       prefs.correoElectronico = entity.correo;
      //       prefs.avatarImagen = entity.avatar;
      //       prefs.nombreInstitucion = entity.nombreInstitucion;
      //       prefs.idInsitucion = entity.idInstitucion;
      //       prefs.idPersonal = entity.idPersonal;
      //       prefs.userId = entity.idUsuario;
      //       prefs.idCreacionInsitucion = entity.idCreacionInstitucion;
      //       prefs.nombreCreacionInstitucion = entity.nombreCreacionInstitucion;

      navegation(context, IntroPage());
    });
    // });
  }

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/general/google_logo.png"),
                height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Iniciar con Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _crearAcciones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.blueAccent,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'FACEBOOK VIRTUAL MATCH'.toString(), url: facebook)),
            child: Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.red,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () => navegation(
                context,
                ViewPage(
                    title: 'FACEBOOK VIRTUAL MATCH'.toString(),
                    url: instagram)),
            child: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.green,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () {
              callWhatsAppText(whatsApp,
                  '*Comunidad Virtual Match:* \n Mensaje. Me gustaría ponerme en contacto. Gracias. \nEnviado desde la aplicación \n*Virtual Match Digital*.');
            },
            child: Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        sizedBox(10, 0),
        SizedBox(
          width: 40,
          height: 40,
          child: RaisedButton(
            color: Colors.grey,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () {
              sendEmailAdvanced(
                  email,
                  "Comunidad Virtual Match. Deseo comunicarme con usted.",
                  "A la Comunidad Virtual Match:\n Deseo más información sobre la Comunidad y de como formar parte de FIFA BOLIVIA.\n Saludos cordiales. Gracias");
            },
            child: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  _egree(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('Política de Privacidad'),
            onPressed: () => Navigator.push(
              context,
              PageTransition(
                curve: Curves.bounceOut,
                type: PageTransitionType.rotate,
                alignment: Alignment.topCenter,
                child: ViewPage(
                    title: 'Políticas de Privacidad',
                    url:
                        'https://www.virtual_match.bo/politicas-de-privacidad'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
      BuildContext context, String text, double fontSize, double edgeInsets) {
    return GFButton(
      padding: EdgeInsets.symmetric(horizontal: edgeInsets),
      text: text,
      textStyle: TextStyle(fontSize: fontSize),
      textColor: AppTheme.themeWhite,
      color: AppTheme.themeBlackBlack,
      icon: avatarCircle(IMAGE_DEFAULT, 20),
      // Shimmer.fromColors(
      //   baseColor: AppTheme.themePurple,
      //   highlightColor: AppTheme.themeWhite,
      //   child: avatarCircle(IMAGE_LOGOB, 35),
      // ),
      shape: GFButtonShape.pills,
      onPressed: () => navegation(context, IntroPage()),
    );
  }

  // Widget _botonInvitado(String text) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 70.0),
  //     width: MediaQuery.of(context).size.width,
  //     child: RaisedButton.icon(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //       color: AppTheme.themeDefault,
  //       textColor: Colors.white,
  //       label: Text(
  //         text,
  //         style: kSubtitleStyle,
  //       ),
  //       icon: FaIcon(FontAwesomeIcons.earlybirds, color: Colors.white),
  //       onPressed: () {
  //         // prefs.imei = entity.imei;
  //         // prefs.nombreUsuario = 'Invitado';
  //         // prefs.correoElectronico = 'Invitado';
  //         // prefs.nombreInstitucion = 'Invitado';
  //         // prefs.idInsitucion = '0';
  //         // prefs.idPersonal = '-2';
  //         // prefs.userId = '0';

  //         // Navigator.push(
  //         //     context,
  //         //     PageTransition(
  //         //       curve: Curves.bounceOut,
  //         //       type: PageTransitionType.rotate,
  //         //       alignment: Alignment.topCenter,
  //         //       child: LoginPage(),
  //         //     ));
  //       },
  //     ),
  //   );
  // }

// void loadingEntity() {
//     entity.idMultimedia = 0;
//     entity.idOrganizacion = int.parse(prefs.idInstitution);
//     entity.idaCategoria = typeMaterial;
//     entity.titulo = controllerNoticia.text;
//     entity.resumen = controllerDetalle.text;
//     entity.fechaInicio = _inputFieldDateInicioController.text;
//     entity.fechaFin = _inputFieldDateFinController.text;
//     entity.usuarioAuditoria = prefs.email;
//     entity.fechaAuditoria = '2020-08-10 08:25';
//     entity.foto = IMAGE_LOGO;
//     entity.enlace = controllerUbicacion.text;
//   }

//   void executeCUD(
//       MultimediaService entityService, MultimediaModel entity) async {
//     try {
//       await entityService.repository(entity).then((result) {
//         print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

//         if (result["tipo_mensaje"] == '0')
//           showSnackbar(STATUS_OK, scaffoldKey);
//         else
//           showSnackbar(STATUS_ERROR, scaffoldKey);
//       });
//     } catch (error) {
//       showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
//     }
//   }

}
