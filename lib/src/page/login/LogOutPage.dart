import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:ui';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/page/login/LogOnPage.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'dart:async';
import 'dart:convert' show json;
import "package:http/http.dart" as http;
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile',
  ],
);

class LogOutPage extends StatefulWidget {
  @override
  _LogOutPageState createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  GoogleSignInAccount _currentUser;
  // ignore: unused_field
  String _contactText;
  final prefs = new Preferense();

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Cargando información del contacto...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });

      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect();
    navegation(context, LogOnPage());
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/portada2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ListTile(
              leading: avatarCircleTransparent(_currentUser.photoUrl, 45),
              title: Text(
                'Nombre del usuario :\n${_currentUser.displayName}' ?? '',
                style: kSigssTitleStyle,
              ),
              subtitle: Text(
                'Correo logeado :\n${_currentUser.email}' ?? '',
                style: kSigssTitleStyle,
              ),
            ),
            Text(
              "Logueo exitoso.!.",
              style: kSigssTitleStyle,
            ),
            Image.asset(
              'assets/icono3.png',
              //scale: 0.4,
              width: 180,
              height: 180,
            ),
            Text(
              "Disfruta de Virtual Match!.",
              style: kSigsTitleStyle,
            ),
            //  Text(_contactText ?? ''),
            _gmailButton(),
          ],
        ),
      );
    } else {
      return Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/portada2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ListTile(
              leading: avatarCircleTransparent(prefs.avatarImage, 45),
              title: Text(
                'Nombre del usuario :\n${prefs.nameUser}  ${prefs.nameUser}' ??
                    '',
                style: kSigssTitleStyle,
              ),
              subtitle: Text(
                'Correo logeado :\n${prefs.email}' ?? '',
                style: kSigssTitleStyle,
              ),
            ),
            Text(
              "Logueo exitoso.!.",
              style: kSigssTitleStyle,
            ),
            Image.asset(
              'assets/icono3.png',
              //scale: 0.4,
              width: 180,
              height: 180,
            ),
            Text(
              "Disfruta de Virtual Match!.",
              style: kSigsTitleStyle,
            ),
            //  Text(_contactText ?? ''),
            _gmailButton(),
          ],
        ),
      );
    }
  }

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: _handleSignOut, // _handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white),
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
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('CERRAR SESIÓN'),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
