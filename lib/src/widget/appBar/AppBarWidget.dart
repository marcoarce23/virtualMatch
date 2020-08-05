import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

AppBar appBar(String title) {
  return AppBar(
    // leading: ImageOvalNetwork(
    //                 imageNetworkUrl: IMAGE_DEFAULT,
    //                 sizeImage: Size.fromWidth(70)),
    backgroundColor: AppTheme.themeWhite,
    toolbarOpacity: 0.7,
    iconTheme: IconThemeData(color: AppTheme.themeDefault, size: 12),
    elevation: 2.0,
    title: Text(title, style: kTitleAppBar),
    actions: <Widget>[
      ImageOvalNetwork(
          imageNetworkUrl: IMAGE_LOGO, sizeImage: Size.fromWidth(50)),
    ],
  );
}
