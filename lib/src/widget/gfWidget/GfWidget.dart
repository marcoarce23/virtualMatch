import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

GFAccordion accordion(String title, String content,
    Color expandedTitlebackgroundColor, Color collapsedTitlebackgroundColor) {
  return GFAccordion(
    title: title,
    content: content,
    contentPadding: EdgeInsets.all(5.0),
    collapsedIcon: Icon(Icons.add),
    expandedIcon: Icon(Icons.minimize),
    expandedTitlebackgroundColor: expandedTitlebackgroundColor,
    collapsedTitlebackgroundColor: collapsedTitlebackgroundColor,
    showAccordion: true,
    titleborder: Border.all(
        color: collapsedTitlebackgroundColor,
        width: 0.5,
        style: BorderStyle.solid),
    contentBorder: Border.all(
        color: collapsedTitlebackgroundColor,
        width: 0.5,
        style: BorderStyle.none),
  );
}

GFTypography textSimple1(FaIcon icon, String text, Color divider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo1,
    icon: icon,
    dividerColor: divider,
    textColor: divider,
  );
}

GFTypography textSimple2(FaIcon icon, String text, Color divider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo2,
    icon: icon,
    dividerColor: divider,
  );
}

GFTypography textImageType1(
    FaIcon icon, String text, String image, Color divider, bool showDIvider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo1,
    icon: icon,
    backgroundImage: NetworkImage(image),
    dividerColor: divider,
    showDivider: showDIvider,
  );
}

GFTypography textImageType2(
    FaIcon icon, String text, String image, Color divider, bool showDIvider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo2,
    icon: icon,
    backgroundImage: NetworkImage(image),
    dividerColor: divider,
    showDivider: showDIvider,
  );
}

GFTypography textImageType3(
    FaIcon icon, String text, String image, Color divider, bool showDIvider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo3,
    icon: icon,
    backgroundImage: NetworkImage(image),
    dividerColor: divider,
    showDivider: showDIvider,
  );
}

GFTypography textImageType4(
    FaIcon icon, String text, String image, Color divider, bool showDIvider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo4,
    icon: icon,
    backgroundImage: NetworkImage(image),
    dividerColor: divider,
    showDivider: showDIvider,
  );
}

GFTypography textImageType5(
    FaIcon icon, String text, String image, Color divider, bool showDIvider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo5,
    icon: icon,
    backgroundImage: NetworkImage(image),
    dividerColor: divider,
    showDivider: showDIvider,
  );
}

GFTypography textImageType6(
    FaIcon icon, String text, String image, Color divider, bool showDIvider) {
  return GFTypography(
    text: text,
    type: GFTypographyType.typo6,
    icon: icon,
    backgroundImage: NetworkImage(image),
    dividerColor: divider,
    showDivider: showDIvider,
  );
}

GFLoader loading() {
  return GFLoader(type: GFLoaderType.circle);
}

GFAvatar avatar(String image, int type, double size) {
  return GFAvatar(
    backgroundImage: NetworkImage(image),
    shape: GFAvatarShape.square,
    size: size,
  );
}

GFProgressBar progressCircle(String text, int type, double fontSize) {
  return GFProgressBar(
    percentage: 0.5,
    lineHeight: 20,
    child: Padding(
      padding: EdgeInsets.only(right: 5),
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    ),
    backgroundColor: Colors.black26,
    progressBarColor: GFColors.WARNING,
  );
}

GFProgressBar progressBar(String text, int type, double fontSize) {
  return GFProgressBar(
    percentage: 0.8,
    lineHeight: 20,
    alignment: MainAxisAlignment.spaceBetween,
    child: Text(
      text,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: fontSize, color: Colors.white),
    ),
    leading: Icon(Icons.sentiment_dissatisfied, color: GFColors.DANGER),
    trailing: Icon(Icons.sentiment_satisfied, color: GFColors.SUCCESS),
    backgroundColor: Colors.black26,
    progressBarColor: GFColors.INFO,
  );
}

GFDrawer drawer(BuildContext context) {
  return GFDrawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        GFDrawerHeader(
          // margin: EdgeInsets.all(10) ,
          currentAccountPicture: GFAvatar(
            radius: 80.0,
            backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"),
          ),
          otherAccountsPictures: <Widget>[
            Image(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg"),
              fit: BoxFit.cover,
            ),
            GFAvatar(
              child: Text("MA"),
            )
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Marco ANtonio'),
              Text('marcoarce23@gmail.com'),
            ],
          ),
        ),
        divider(),
        ListTile(
          title: Text('Buscar tiendas virtual_match'),
          onTap: () => navegation(context, IntroPage()),
        ),
        ListTile(
          title: Text('Acerca de ..'),
          onTap: () => navegation(context, IntroPage()),
        ),
      ],
    ),
  );
}

// CustomListTile(Icons.search, '   Buscar tiendas virtual_match',
//             () => navegation(context, IntroPage())),
//         CustomListTile(Icons.store, '    Tiendas más valoradas',
//             () => navegation(context, LoginPage())),
//         CustomListTile(Icons.favorite, '   Lo más favorito',
//             () => navegation(context, IntroPage())),
//         CustomListTile(Icons.add_shopping_cart, '   Mis pedidos',
//             () => navegation(context, IntroPage())),
//         CustomListTile(Icons.supervised_user_circle, '    Sobre nosotros',
//             () => navegation(context, LoginPage())),
//         CustomListTile(
//             Icons.share,
//             '    Comparte la aplicación',
//             () => sharedText(
//                 'Comparte la App - SomosUnoBolivia',
//                 '🔺*virtual_match*🔺 \n Una aplicación de ventas por catálogo virtual.\n💬Atención *CATALOGO VIRTUAL* personalizada. \n 📲 Puede descargar la app desde: https://play.google.com/store/apps/details?id=bo.virtual_matchBolivia',
//                 'text/html')),
//         CustomListTile(Icons.settings, '    Configuración',
//             () => navegation(context, LoginPage())),
//         CustomListTile(Icons.add_to_home_screen, '   Acerca de la aplicación',
//             () => navegation(context, IntroPage())),
//         CustomListTile(Icons.exit_to_app, '    Cerrar Sesión',
//             () => navegation(context, LoginPage())),
