import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';

class SorojchiPage extends StatefulWidget {
  SorojchiPage({Key key}) : super(key: key);

  @override
  _SorojchiPageState createState() => _SorojchiPageState();
}

class _SorojchiPageState extends State<SorojchiPage> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('SOROJCHI ECLUB'),
        drawer: DrawerMenu(),
        floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
            FaIcon(FontAwesomeIcons.playstation), HomePage()),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearImagen(context),
              _crearTitulo(),
              _crearAcciones(context),
              divider(),
              _crearTexto(),
              sizedBox(0, 10),
              _crearTexto1(),
              sizedBox(0, 10),
              _crearTexto0(),
              sizedBox(0, 10),
              _crearTexto2(),
              sizedBox(0, 10),
              _crearTexto3(),
              sizedBox(0, 10),
              _crearTexto4(),
              copyRigth()
            ],
          ),
        ));
  }

  Widget _crearImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'scroll'),
        child: Image(
          image: NetworkImage(IMAGE_ORGANIZATION),
          height: 180.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Comunidad Sorojchi eclub - @ComunidadFIFABoliviaInicio',
                      style: estiloTitulo),
                  sizedBox(0, 7.0),
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

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'FIFA BOLIVIA o Virtual Match es una empresa boliviana donde se organiza torneos de fútbol virtual (FIFA) ON-LINE y PRESENCIALES para la plataforma Play station 4 y XBOX One. Ademas, se garantiza mucha habilidad, estrategia y abundantes premios para los primeros lugares. ',
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
          'Organizamos torneos desde los ya existentes y mas populares en el mundo real como los totalmente originales creados por esta Comunidad. Ademas se organizaran torneos de:',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto0() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              '1 Vs 1',
              textAlign: TextAlign.justify,
            ),
            Text(
              '2 Vs 2',
              textAlign: TextAlign.justify,
            ),
            Text(
              'Torneos presenciales ',
              textAlign: TextAlign.justify,
            ),
            Text(
              'Clubes Pro',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearTexto2() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Por otro lado, buscamos llevar a otro nivel los E-Sports en Bolivia, haciendo lo posible de llamar la atención de los clubes bolivianos en el país y formar jugadores profesionales de fifa para que algún día Bolivia sea representado profesionalmente.',
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
          'Así mismo, se pretende que exista una diversidad de culturas de todo el país, donde se comparta con otras personas de diferentes ciudades o departamentos de Bolivia.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto4() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'La idea es que se disfrute y se aproveche al máximo tus habilidades en el juego FIFA. Ya que de por si es un excelente juego y que mejor aprovecharlo al máximo compitiendo contra otros rivales y representando a tu país en eventos Internacionales.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
