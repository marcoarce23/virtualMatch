import 'dart:io';

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
import 'package:virtual_match/src/model/entity/EntityFromJson/LogOnModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/LogOnModel.dart'
    as model;
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/model/util/StatusCode.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/page/login/LoginClipperPage.dart';
import 'package:virtual_match/src/service/LogInService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogOnPage extends StatefulWidget {
  @override
  _LogOnPageState createState() => _LogOnPageState();
}

class _LogOnPageState extends State<LogOnPage> {
  LoginService loginService1;

  LoginService loginService = new LoginService();
  LoginModel loginModel = new LoginModel();
  model.LoginModel entity = new model.LoginModel();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = new Preferense();
  //LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  String result2;
  var result;
  var result1;
  final Future<bool> _isAvailableFuture = AppleSignIn.isAvailable();

  String errorMessage;

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
    checkLoggedInState();

    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }

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
    loginService1 = Provider.of<LoginService>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Stack(
          children: [
            Container(),
            Image.asset(
              "assets/vm_logo.png",
              fit: BoxFit.cover,
              height: size.height * 0.63,
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

// AppleSignInButton(
//   style: ButtonStyle.black,
//   type: ButtonType.continueButton,
//   onPressed: appleLogIn,
// );

  void checkLoggedInState() async {
    final userId = '';

    final credentialState = await AppleSignIn.getCredentialState(userId);
    switch (credentialState.status) {
      case CredentialStatus.authorized:
        print("getCredentialState returned authorized");
        break;

      case CredentialStatus.error:
        print(
            "getCredentialState returned an error: ${credentialState.error.localizedDescription}");
        break;

      case CredentialStatus.revoked:
        print("getCredentialState returned revoked");
        break;

      case CredentialStatus.notFound:
        print("getCredentialState returned not found");
        break;

      case CredentialStatus.transferred:
        print("getCredentialState returned not transferred");
        break;
    }
  }

  void appleLogIn() async {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:

      case AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");
        setState(() {
          errorMessage = "Sign in failed 😿";
        });
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
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
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppleSignInButton(
            type: ButtonType.continueButton,
            onPressed: appleLogIn,
          ),
          _gmailButton(),
          _button(context, 'Virtual Match', 18.0, 20.0),
          _crearAcciones(context),
          _egree(context),
          copyRigthClear(),
        ],
      ),
    );
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      _crearInformacion();
    } catch (error) {
      showSnackbar(
          result["mensaje"].toString() + error.toString(), scaffoldKey);
    }
  }

  _crearInformacion() async {
    _googleSignIn.signIn().then((value) {
      prefs.nameUser = currentUser.displayName;
      prefs.email = currentUser.email;
      prefs.avatarImage = currentUser.photoUrl;
      prefs.userId = currentUser.displayName;
      _submit();
    });
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
                    title: 'INSTAGRAM VIRTUAL MATCH'.toString(),
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
                  '*Comunidad Virtual Match:* \n Mensaje. Me gustaría ponerme en contacto. Gracias. \n\nEnviado desde la aplicación \n\n*Virtual Match Digital*.');
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
                  "A la Comunidad Virtual Match:\n\n Deseo más información sobre la Comunidad y de como formar parte de FIFA BOLIVIA.\n\n Saludos cordiales. Gracias");
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
            onPressed: () => navegation(
              context,
              ViewPage(
                  title: 'Políticas de Privacidad',
                  url: 'https://www.virtual_match.bo/politicas-de-privacidad'),
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
      icon: Image.asset(
        'assets/icono3.png',
        //scale: 0.4,
        width: 30,
        height: 30,
      ),
      shape: GFButtonShape.pills,
      onPressed: _submitInvitado,
    );
  }

  _submitInvitado() {
    print('entra a boton invitado');
    prefs.idPlayer = '-1';
    prefs.idLogin = '-1';

    navegation(context, IntroPage());
  }

  _submit() async {
    print('IDPLAYERRR;; ${prefs.idPlayer.toString()}');

    if (prefs.idPlayer != '-1') {
      navegation(context, HomePage());
    } else {
      loadingEntity();
    }
  }

  loadingEntity() async {
    entity.states = StateEntity.Insert;
    entity.foto = prefs.avatarImage;
    entity.nombre = prefs.nameUser;
    entity.correo = prefs.email;
    entity.imei = _platformImei;
    entity.token = prefs.token;
    await executeCUD(loginService, entity);
  }

  executeCUD(LoginService entityService, model.LoginModel entity) async {
    try {
      await entityService.repository(entity).then((result) {
        print('EL RESULTTTTT: ${result["tipo_mensaje"]}');

        if (result["tipo_mensaje"] == '0') {
          prefs.idLogin = result["data"]["idLogin"].toString();
          prefs.idPlayer = result["data"]["idPlayer"].toString();

          if (int.parse(prefs.idPlayer) > 0) {
            prefs.idOrganization =
                result["jugador"]["idOrganizacion"].toString();
            prefs.idDepartament =
                int.parse(result["jugador"]["idaDepartamento"].toString());
            prefs.nameUser = result["jugador"]["nombre"].toString();
            prefs.apellido = result["jugador"]["apellido"].toString();
            prefs.avatarImage = result["jugador"]["foto"].toString();
            prefs.idPsdn = result["jugador"]["idPsdn"].toString();
            prefs.telefono = result["jugador"]["telefono"].toString();
            prefs.idaSexo = int.parse(result["jugador"]["idaSexo"].toString());
            prefs.informacionComplementaria =
                result["jugador"]["informacionComplementaria"].toString();
            prefs.facebook = result["jugador"]["facebook"].toString();
            prefs.twitter = result["jugador"]["twitter"].toString();
          }

          navegation(context, IntroPage());
        } else
          showSnackbar(STATUS_ERROR, scaffoldKey);
      });
    } catch (error) {
      showSnackbar(STATUS_ERROR + ' ${error.toString()} ', scaffoldKey);
    }
  }
}
