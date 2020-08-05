import 'dart:async';
import 'package:rxdart/rxdart.dart';

//IMPORT DEL PROYECTO.
import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/bloc/util/validator.dart';
import 'package:virtual_match/src/provider/notification/ApiAdd.dart';
import 'package:virtual_match/src/provider/notification/ApiUpdate.dart';
import 'package:virtual_match/src/provider/notification/ApiDelete.dart';
import 'package:virtual_match/src/model/entity/EntityMap/NotificacionModel.dart';

class NotificationBloc with Validators {
  final _controller = new BehaviorSubject<List<NotificacionModel>>();
  final _loadingController = new BehaviorSubject<bool>();
  final _apiAdd = new ApiAdd();
  final _apiDelete = new ApiDelete();
  final _apiUpdate = new ApiUpdate();

  Stream<List<NotificacionModel>> get eventStream => _controller.stream;
  Stream<bool> get loading => _loadingController.stream;

  void getAll() async {
    // final Notificationos = await _NotificationosProvider.cargarNotificationos();
    // _NotificationosController.sink.add(Notificationos);
  }

  Future<Map<String, dynamic>> repository(IEntityMap entity) async {
    var result;
    print('STATE ENTIRY: ${entity.states}');

    _loadingController.sink.add(true);
    switch (entity.states) {
      case StateEntity.Insert:
        result = await _apiAdd.add(entity);
        break;
      case StateEntity.Delete:
        result = await _apiDelete.delete(entity);
        break;
      case StateEntity.Update:
        result = await _apiUpdate.update(entity);
        break;
      default:
    }
    _loadingController.sink.add(false);
    print('DEL VALOR DE EVENT BLOC: $result');
    return result;
  }

  dispose() {
    _controller?.close();
    _loadingController?.close();
  }
}
