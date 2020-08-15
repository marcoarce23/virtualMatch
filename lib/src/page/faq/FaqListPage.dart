import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/general/ViewPage.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class FaqListPage extends StatefulWidget {
  FaqListPage({Key key}) : super(key: key);

  @override
  _FaqListPagetate createState() => _FaqListPagetate();
}

class _FaqListPagetate extends State<FaqListPage> {
  File photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('PREGUNTAS FRECUENTES'),
      drawer: DrawerMenu(),
      body: Stack(
        children: <Widget>[
          _form(context),
        ],
      ),
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          sizedBox(0.0, 15.0),
          Container(
            width: size.width * 0.96,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            decoration: containerImage(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            ),
          ),
          Container(
            width: size.width * 0.96,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: _fields(context),
          ),
          copyRigth(),
        ],
      ),
    );
  }

  Widget _fields(BuildContext context) {
    return Column(
      children: <Widget>[
        sizedBox(0.0, 0.0),
        showInformation(
            context,
            'TIENES CONSULTAS ?',
            'Acá te respondemos las preguntas mas comunes sobre la Comunidad Virtual Match y nuestra APP',
            'Visita Sorojchi eclub en facebook',
            'INGRESASTE A SORIJCHI ECLUB',
            'https://www.facebook.com/SorojchieClub/'),
        listAcordion(),
        listAcordion2(),
        listAcordion3(),
        listAcordion4(),
      ],
    );
  }

  Widget _showInformation(String url) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 0.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          gfListTile(
              Text('TIENES CONSULTAS ?'),
              Text(
                  'Acá te respondemos las preguntas mas comunes sobre la Comunidad Virtual Match y nuestra APP'),
              Row(
                children: <Widget>[
                  Text(
                    'Visita Sorojchi eclub en facebook',
                    style: TextStyle(
                        color: AppTheme.themePurple,
                        textBaseline: TextBaseline.ideographic,
                        //   decoration: TextDecoration.underline,
                        fontSize: 15.0),
                  ),
                  InkWell(
                    child: avatarCircle(IMAGE_LOGO, 20),
                    onTap: () => navegation(
                        context,
                        ViewPage(
                            title: 'Visita Sorojchi'.toString(),
                            url: 'https://www.facebook.com/SorojchieClub/')),
                  ),
                ],
              ),
              null,
              avatarCircle(IMAGE_LOGO, 35),
              EdgeInsets.all(5.0),
              EdgeInsets.all(3.0)),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget listAcordion() {
    return accordion(
        '¿Cómo puedo contactarlos?',
        'Contamos con distintos canales de atención, cualquier duda o consulta que tengas siéntete libre de preguntar mediante: \nNuestras redes sociales: Facebook Instagram \nCorreo electrónico info@impulse.bo \nNúmero de WhatsApp +591 61677470',
        AppTheme.themeDefault,
        AppTheme.themePurple);
  }

  Widget listAcordion2() {
    return accordion(
        '¿Cuál es el horario de atención?',
        'Puedes contactarnos en cualquier momento, para recibir respuestas más inmediatas nuestro horario es el siguiente: 9:00 AM a 8 :00 PM de lunes a viernes.',
        AppTheme.themeDefault,
        AppTheme.themePurple);
  }

  Widget listAcordion3() {
    return accordion(
        '¿Este es un sitio seguro?',
        'Ten la confianza de que tu información está siendo gestionada de la manera correcta y que este sitio web tiene los certificados de seguridad SSL correspondientes.',
        AppTheme.themeDefault,
        AppTheme.themePurple);
  }

  Widget listAcordion4() {
    return accordion(
        '¿Cómo realizan el servicio de despacho?',
        'Los despachos los realizamos habiendo confirmado la información de los pedidos y realizado el empaque y procediendo de despacho hasta las 9:00 AM en días hábiles. Para que tu producto este seguro tenemos tres métodos de entrega:\nEntrega gratuita a domicilio para las principales ciudades del país.\nEntrega mediante oficinas FedEx de todo el país (si vive en una provincia o bien lo desee así).\nEntrega mediante las tiendas Impulse.',
        AppTheme.themeDefault,
        AppTheme.themePurple);
  }
}
