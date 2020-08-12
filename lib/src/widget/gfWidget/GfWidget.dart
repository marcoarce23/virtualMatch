import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/intro/IntroPage.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

final prefs = new Preferense();

GFListTile gfListTile(Widget title, Widget subTitle, Widget description,
    FaIcon icon, Widget avatar, EdgeInsets padding, EdgeInsets margin) {
  return GFListTile(
      avatar: avatar,
      title: title,
      subTitle: subTitle,
      description: description,
      padding: padding,
      margin: margin,
      icon: icon
      );
}

GFListTile gfListTileText(String title, String subTitle, FaIcon icon,
    Widget avatar, EdgeInsets padding, EdgeInsets margin) {
  return GFListTile(
      avatar: avatar,
      titleText: title,
      subtitleText: subTitle,
      padding: padding,
       margin: margin,
       icon: icon,
      );
}

GFShimmer gfsShimmerWidget(
  Widget widget,
  Color color1,
  Color color2,
  Color color3,
  Color color4,
  Color color5,
) {
  return GFShimmer(
    child: widget,
    showGradient: true,
    showShimmerEffect: true,
    gradient: LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.centerLeft,
      stops: const <double>[0, 0.3, 0.6, 0.9, 1],
      colors: [
        color1,
        color2,
        color3,
        color4,
        color5,
      ],
    ),
  );
}

GFShimmer gfsShimmerText(
  String text,
  double fontSize,
  Color color1,
  Color color2,
  Color color3,
  Color color4,
  Color color5,
) {
  return GFShimmer(
    child: Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
    ),
    showGradient: true,
    showShimmerEffect: true,
    gradient: LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.centerLeft,
      stops: const <double>[0, 0.3, 0.6, 0.9, 1],
      colors: [
        color1,
        color2,
        color3,
        color4,
        color5,
      ],
    ),
  );
}

GFCard gfCard(String textButton, String textContext, String textTitle,
    double elevation, Function iconFuction, Function onPressed) {
  return GFCard(
    boxFit: BoxFit.cover,
    image: Image.network(IMAGE_LOGO),
    elevation: elevation,
    title: GFListTile(
        title: Text(textTitle),
        icon: GFIconButton(
          onPressed: iconFuction,
          icon: Icon(Icons.favorite_border),
          type: GFButtonType.transparent,
        )),
    content: Text(textContext),
    buttonBar: GFButtonBar(
      alignment: WrapAlignment.start,
      children: <Widget>[
        GFButton(
          onPressed: onPressed,
          text: textButton,
        ),
      ],
    ),
  );
}

GFCard gfCardAdvanced(
    String textButton,
    String textContext,
    String textTitle,
    String textSubTitle,
    double elevation,
    Widget avatar,
    Function iconFuction,
    Function onPressed) {
  return GFCard(
    boxFit: BoxFit.cover,
    image: Image.network(IMAGE_LOGO),
    border:
        Border.all(color: Colors.black, width: 2.0, style: BorderStyle.solid),
    elevation: elevation,
    title: GFListTile(
        title: Text(textTitle),
        subTitle: Text(textSubTitle),
        avatar: avatar,
        icon: GFIconButton(
          onPressed: iconFuction,
          icon: Icon(Icons.favorite_border),
          type: GFButtonType.transparent,
        )),
    content: Text(textContext),
    buttonBar: GFButtonBar(
      alignment: WrapAlignment.start,
      children: <Widget>[
        GFButton(
          onPressed: onPressed,
          text: textButton,
        ),
      ],
    ),
  );
}

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

GFAvatar avatarSquare(String image,  double size) {
  return GFAvatar(
    backgroundImage: NetworkImage(image),
    shape: GFAvatarShape.square,
    size: size,
  );
}

GFAvatar avatarCircle(String image, double size) {
  return GFAvatar(
    backgroundImage: NetworkImage(image),
    backgroundColor: Colors.black,
    foregroundColor: Colors.black,
    shape: GFAvatarShape.circle,
    size: size,
  );
}

GFProgressBar progressCircle(String text, double fontSize) {
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
            backgroundImage: NetworkImage(IMAGE_LOGO),
          ),
          otherAccountsPictures: <Widget>[
            Image(
              image: NetworkImage(IMAGE_LOGO),
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
              Text(prefs.nameUser),
              Text(prefs.email),
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
