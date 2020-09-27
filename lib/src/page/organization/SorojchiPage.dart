import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';
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
  final estiloTitulo = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black);
  final estiloSubTitulo =
      TextStyle(fontSize: 18.0, color: AppTheme.themeDefault);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Colors.black87,
        appBar: appBar('Sorojchi Eclub'),
        drawer: DrawerMenu(),
        floatingActionButton: floatButtonImage(AppTheme.themePurple, context,
            FaIcon(FontAwesomeIcons.playstation), HomePage()),
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/portada1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                backgroundBasic(context),
                _crearImagen(context),
                sizedBox(0, 10),
                _crearTitulo(),
                _crearAcciones(context),
                dividerBlack(),
                _crearTexto(),
                sizedBox(0, 10),
                _crearTexto1(),
                sizedBox(0, 10),
                _crearTexto2(),
                sizedBox(0, 10),
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
            'assets/vm_sorojchi.png',
            //scale: 0.4,
            height: 150.0,
            fit: BoxFit.fill,
          )),
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
                  Shimmer.fromColors(
                    baseColor: AppTheme.themeDefault,
                    highlightColor: AppTheme.themePurple,
                    child: Text('Acerca de Sorojchi eClub'.toUpperCase(),
                        style: estiloTitulo),
                  ),
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
          '■Sorojchi eClub es un nuevo club de deportes electrónicos fundado el 2 de julio de 2019 por Edison Paredes (Presidente de Comunidad FIFA Bolivia) que tiene por objetivo reunir a los jugadores más talentosos para participar en competiciones oficiales de EA Sports FIFA.',
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
          '■En la actualidad el club está formado por los bolivianos Julio Calderón,  Mauricio Angulo y Jorge Trigo. Julio es el máximo campeón de torneos FIFA de todo el país, actualmente es poseedor de los campeonatos nacionales de FIFA 18 – FIFA 19 Y FIFA20 sin duda el jugador con más campeonatos nacionales en su haber. También es el jugador de fútbol virtual más seguido del país por jóvenes promesas fiferas que quieren llegar a ser como él y lo toman como ejemplo.',
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
          '■Mauricio Angulo es el vigente campeón (en la modalidad de equipos libres) de los últimos torneos más importantes del panorama nacional pertenecientes a las competiciones de EA Sports Fifa20 y organizada por FIFA BOLIVIA. ',
          style: kSubtitleStyleBlack,
          softWrap: true,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
