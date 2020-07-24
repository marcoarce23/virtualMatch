import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

class OrganizationPage extends StatefulWidget {
  OrganizationPage({Key key}) : super(key: key);

  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarOpacity: 0.7,
          iconTheme: IconThemeData(color: AppTheme.themeDefault, size: 12),
          elevation: 0,
          title: Text("CONOCE SOBRE virtual_match", style: kTitleAppBar),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       // showSearch(context: context, delegate: DataSearchVoluntary());
          //     },
          //   )
          // ],
        ),
        drawer: DrawerMenu(),
        floatingActionButton: floatButton(AppTheme.themeOrange, context,
            FaIcon(FontAwesomeIcons.home), HomePage()),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearImagen(context),
              _crearTitulo(),
              _crearAcciones(),
              divider(),
              _crearTexto(),
              _crearTexto1(),
              _crearTexto2(),
              _crearTexto3(),
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
          image: NetworkImage(
              'https://res.cloudinary.com/propia/image/upload/v1594933808/lvoonq7qcl9jmojlws70.jpg'),
          //   'https://res.cloudinary.com/propia/image/upload/v1594750950/gzikny5up1aqzm2vfdna.jpg'),
          height: 230.0,
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
                  Text('virtual_match, lo último en moda para tí',
                      style: estiloTitulo),
                  // Text('Terrasur, haciendo tus sueños realidad',
                  //     style: estiloTitulo),
                  SizedBox(height: 7.0),
                  //Text('Fecha: XXXXX', style: estiloSubTitulo ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FaIcon(FontAwesomeIcons.phoneSquareAlt, color: Colors.grey, size: 30.0),
        FaIcon(FontAwesomeIcons.whatsappSquare, color: Colors.grey, size: 30.0),
        FaIcon(FontAwesomeIcons.instagramSquare,
            color: Colors.grey, size: 30.0),
      ],
    );
  }

  // Widget _accion(FontAwesomeIcons icon, String texto ) {

  //   return Column(
  //     children: <Widget>[
  //       FaIcon( icon, color: Colors.black54, size: 40.0 ),
  //       SizedBox( height: 5.0 ),
  //       Text( texto, style: TextStyle( fontSize: 15.0, color: Colors.black87), )
  //     ],
  //   );

  // }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          'virtual_match  es una empresa de bienes raíces con mas de 20 años en el mercado nacional y lideres en venta de terrenos urbanizados. Terrasur ofrece lotes de terreno en la ciudad de La Paz (Achumani, Mallasa, Lipari, Río Abajo, El palomar y otros  ), El Alto (Viacha, Ventilla y Mazo Cruz) y Santa Cruz (Urubó). Ofrece crédito directo desde los 5, 10 y hasta 15 años plazo a sola firma.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto1() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          'Con una gran visión de negocio y notable claridad en sus inversiones, la empresa inmobiliaria hace del desarrollo de urbanizaciones su principal actividad desde sus inicios, convirtiendo grandes extensiones de terreno en lo que hoy son importantes áreas urbanas destinadas a la vivienda y múltiples actividades comerciales, con el consiguiente desarrollo del sector.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto2() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          'En poco tiempo, Terrasur se especializó en la compra de terrenos, adecuación y proyección del sector, diseño de planimetrías, aprobación de urbanizaciones, comercialización y financiamiento propio para toda su oferta, al mismo tiempo ha generado una importante cantidad fuentes de trabajo de manera directa e indirecta.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto3() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          'Impulsa la compra de un terreno propio, otorgando financiamiento directo sin garantías hipotecarias, a sola firma, con cuota inicial mínima de hasta Sus 100 y el interés más bajos del mercado. ',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _crearTexto4() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          'Cuenta con dos sucursales, una ubicada en la ciudad de La Paz en la calle Belisario Salinas Nº 525, zona Sopocachi, teléfonos: 2423034 - 2423090 int. 116 y otra en la ciudad de El Alto en la Av. Alfonso Ugarte Nº 274 entre las calles Chacón y Sgto. Carrasco, zona Ballivián, teléfono: 2843310.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
