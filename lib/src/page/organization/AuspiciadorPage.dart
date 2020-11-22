import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';

class AuspiciadorPage extends StatefulWidget {
  AuspiciadorPage({Key key}) : super(key: key);

  @override
  _AuspiciadorPageState createState() => _AuspiciadorPageState();
}

class _AuspiciadorPageState extends State<AuspiciadorPage> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('CONOCE DXRACER'),
        drawer: DrawerMenu(),
        floatingActionButton: floatButtonImage(Colors.transparent, context,
            FaIcon(FontAwesomeIcons.playstation), HomePage()),
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada1.png'),
                //   fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                _crearImagen(context),
                _crearTitulo(),
                _crearAcciones(context),
                dividerBlack(),
                _crearTexto(),
                sizedBox(0, 10),
                _crearTexto1(),
                sizedBox(0, 10),
                _crearTexto2(),
                sizedBox(0, 10),
                _crearTexto3(),
                copyRigthBlack()
              ],
            ),
          ),
        ));
  }

  Widget _crearImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'scroll'),
        child: Image.asset(
          'assets/aus3.jpg',
          //scale: 0.4,
          height: 150.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('ACERCA DE DxrAcer.', style: estiloTitulo),
                  // Text('Terrasur, haciendo tus sueños realidad',
                  //     style: estiloTitulo),
                  sizedBox(0, 7.0),
                  //Text('Fecha: XXXXX', style: estiloSubTitulo ),
                ],
              ),
            ),
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
                    title: 'FACEBOOK DXRACER'.toString(),
                    url: 'www.facebook.com/TecmarkFans')),
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
                    title: 'INSTAGRAM DXRACER'.toString(),
                    url: 'tecmark_fans')),
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
              callWhatsAppText(70121723,
                  '*DXRACER:* \n Mensaje. Me gustaría ponerme en contacto con su empresa. Gracias. \nEnviado desde la aplicación \n*Virtual Match*.');
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
                  "Empresa DXRACER. Deseo comunicarme con usted.",
                  "DXRACER:\n Deseo más información sobre la Comunidad y consultar sobre sus productos.\n Saludos cordiales. Gracias");
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

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          '■  DXRACER .......',
          style: kSubtitleStyleBlack,
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto1() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          '■  DXRACER .......',
          style: kSubtitleStyleBlack,
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto2() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          '■  DXRACER .......',
          style: kSubtitleStyleBlack,
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto3() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          '■  DXRACER .......',
          style: kSubtitleStyleBlack,
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
