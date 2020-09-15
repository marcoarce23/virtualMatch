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

class SocialPage extends StatefulWidget {
  SocialPage({Key key}) : super(key: key);

  @override
  _SocialPagePageState createState() => _SocialPagePageState();
}

class _SocialPagePageState extends State<SocialPage> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('AYUDA SOCIAL'),
        drawer: DrawerMenu(),
        floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
            FaIcon(FontAwesomeIcons.playstation), HomePage()),
        body: SingleChildScrollView(
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
              sizedBox(0, 10),
              _crearTexto4(),
              copyRigthBlack()
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
                  Text('Acerca de la AYUDA SOCIAL VIRTUAL MATCH. Qué hacemos?',
                      style: estiloTitulo),
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
          'Virtual Match en una comunidad de FIFA en Bolivia que nació en febrero del 2016, constituido como empresa unipersonal legalmente registrada en Bolivia el 1 de agosto de 2017,  representada legalmente por su propietario Edison Paredes. Desde su inicio, apuesta por asentar unas bases sólidas y de referencia dentro del mundo del fútbol virtual en los deportes electrónicos. Teniendo como pilares la Identidad,  determinación, identidad, determinación, pasión y trabajo en equipo que hacen parte de nuestro ADN.',
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
          'Desde nuestro inicio solo tenemos un objetivo: Profesionalizar el fútbol virtual en Bolivia y al mismo tiempo formar jugadores profesionales de fifa para que en un futuro cercano Bolivia sea representado profesionalmente a nivel internacional.',
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
          'Así mismo, se pretende llegar a ser una de las empresas de eSports de referencia en el panorama de los deportes electrónicos. Para ello, contamos con un equipo de profesionales multidisciplinares que nos acompañan en el desarrollo de la marca.',
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
          'Además se pretende que en la comunidad fifera exista una diversidad de culturas y una integración de todo el país, donde se comparta con otras personas de diferentes ciudades o departamentos de Bolivia. La idea es que nuestros miembros disfruten y aprovechen al máximo tus habilidades en el juego FIFA. Ya que es un juego que promueve la competitividad e incentiva a la mejora constante de habilidades del jugador, donde se desarrollan mejor  compitiendo contra otros rivales y dando la posibilidad de representar al país en eventos Internacionales.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
