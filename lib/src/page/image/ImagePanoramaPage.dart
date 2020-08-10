import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/page/core/player/PlayerLoadPage.dart';
import 'package:virtual_match/src/page/home/CircularMenuPage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:panorama/panorama.dart';
import 'package:image_picker/image_picker.dart';

class ImapePanoramaPage extends StatefulWidget {
  ImapePanoramaPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImapePanoramaPageState createState() => _ImapePanoramaPageState();
}

class _ImapePanoramaPageState extends State<ImapePanoramaPage> {
  File _imageFile;

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTOS EN 360°'),
      ),
      body: Panorama(
        animSpeed: 2.0,
        child: _imageFile != null
            ? Image.file(_imageFile)
            : Image.asset('assets/panorama.jpg'),
      ),
      drawer: DrawerMenu(),

      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Colors.white.withAlpha(25),
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 64.0,
          fabElevation: 8.0,

          // Also can use specific color based on wether
          // the menu is open or not:
          // fabOpenColor: Colors.white
          // fabCloseColor: Colors.white
          // These properties take precedence over fabColor
          fabColor: AppTheme.themeWhite,
          fabOpenIcon: Icon(Icons.menu, color: AppTheme.themeBlackGrey),
          fabCloseIcon: Icon(Icons.close, color: AppTheme.themeBlackGrey),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {
            _showSnackBar(
                context, "Menu Virtual Match ${isOpen ? "abierto" : "cerrado"}");
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "Selecciono  1");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: FaIcon(FontAwesomeIcons.shoppingCart,
                  color: AppTheme.themeWhite, size: 35.0),
            ),
            RawMaterialButton(
              onPressed: () async {
                _imageFile =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: FaIcon(FontAwesomeIcons.images,
                  color: AppTheme.themeWhite, size: 35.0),
            ),
            RawMaterialButton(
              onPressed: () {
                navegation(context, PlayerLoadPage());
                
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: FaIcon(FontAwesomeIcons.users,
                  color: AppTheme.themeWhite, size: 35.0),
            ),
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "Selecciono Cerrar Menu Circular");
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: FaIcon(FontAwesomeIcons.timesCircle,
                  color: AppTheme.themeWhite, size: 35.0),
            )
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   mini: true,
      //   onPressed: () async {
      //     _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      //     setState(() {});
      //   },
      //   child: Icon(Icons.panorama),
      // ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
      backgroundColor: AppTheme.themeGrey,
    ));
  }
}
