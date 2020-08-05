import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:virtual_match/src/bloc/util/validator.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/LogOnModel.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NotificacionModel.dart';
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/provider/notification/ApiAdd.dart';
import 'package:virtual_match/src/provider/notification/ApiDelete.dart';
import 'package:virtual_match/src/provider/notification/ApiUpdate.dart';
//import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _controller = new BehaviorSubject<List<LoginModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  Stream<List<LoginModel>> get loginStream => _controller.stream;
  Stream<bool> get loading => _loadingController.stream;

  dispose() {
    _controller?.close();
    _loadingController?.close();
  }
}
