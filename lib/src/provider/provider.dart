import 'package:flutter/material.dart';

import 'package:virtual_match/src/bloc/login/LoginBloc.dart';
import 'package:virtual_match/src/bloc/Event/EventBloc.dart';
import 'package:virtual_match/src/bloc/multimedia/MultimediaBloc.dart';
import 'package:virtual_match/src/bloc/new/NewBloc.dart';
import 'package:virtual_match/src/bloc/notification/NotificationBloc.dart';
import 'package:virtual_match/src/bloc/organization/OrganizationBloc.dart';
import 'package:virtual_match/src/bloc/panorama/PanoramaBloc.dart';
import 'package:virtual_match/src/bloc/message/MessageBloc.dart';
import 'package:virtual_match/src/bloc/comment/CommentBloc.dart';
import 'package:virtual_match/src/bloc/core/album/AlbumBloc.dart';
import 'package:virtual_match/src/bloc/core/score/ScoreBloc.dart';
import 'package:virtual_match/src/bloc/core/catalog/CatalogBloc.dart';
import 'package:virtual_match/src/bloc/core/foldeable/FoldeableBloc.dart';
import 'package:virtual_match/src/bloc/core/player/PlayerBloc.dart';
import 'package:virtual_match/src/bloc/core/ranking/RankingBloc.dart';
import 'package:virtual_match/src/bloc/core/result/ResultBloc.dart';
import 'package:virtual_match/src/bloc/product/ProductBloc.dart';

class Provider extends InheritedWidget {
  final _loginBloc = new LoginBloc();
  final _eventBloc = new EventBloc();
  final _multimediaBloc = new MultimediaBloc();
  final _newBloc = new NewBloc();
  final _messageBloc = new MessageBloc();
  final _commentsBloc = new CommentBloc();
  final _organizationBloc = new OrganizationBloc();
  final _notificationBloc = new NotificationBloc();
  // Bloc del core del sistema
  final _albumBloc = new AlbumBloc();
  final _panoramaBloc = new PanoramaBloc();
  final _catalogBloc = new CatalogBloc();
  final _foldeableBloc = new FoldeableBloc();
  //final _miniTournmentBloc = new MiniTourmentBloc();
  final _playerBloc = new PlayerBloc();
  final _productBloc = new ProductBloc();
  final _rankingBloc = new RankingBloc();
  final _resultBloc = new ResultBloc();
  final _scoreBloc = new ScoreBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._loginBloc;
  }

// PARA LO STANDARD

  static CommentBloc commentsBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._commentsBloc;
  }

  // static NotificationBloc notificationBloc(BuildContext context) {
  //   return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
  //           as Provider)
  //       ._notificationBloc;
  // }

  //   static NotificationBloc notificationBloc(BuildContext context) {
  //   return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
  //           as Provider)
  //       ._notificationBloc;
  // }

  static ProductBloc productBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._productBloc;
  }

  static NotificationBloc notificationBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NotificationBloc) as Provider)
        ._notificationBloc;
  }

  static MessageBloc messageBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._messageBloc;
  }

  static MultimediaBloc multimediaBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._multimediaBloc;
  }

  static OrganizationBloc organizationBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._organizationBloc;
  }

  static NewBloc newBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._newBloc;
  }

  static CatalogBloc catalogBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._catalogBloc;
  }

// PROVIDER DEL CORE
  static AlbumBloc albumBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._albumBloc;
  }

  static PanoramaBloc panoramaBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._panoramaBloc;
  }

  static FoldeableBloc foldeableBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._foldeableBloc;
  }

  static PlayerBloc playerBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._playerBloc;
  }

  static ResultBloc resultBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._resultBloc;
  }

  static RankingBloc rankingBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._rankingBloc;
  }

  static ScoreBloc scoreBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
            as Provider)
        ._scoreBloc;
  }
}
