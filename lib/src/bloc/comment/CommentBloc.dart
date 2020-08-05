import 'dart:async';

import 'package:virtual_match/src/model/entity/EntityFromJson/EventModel.dart';
import 'package:virtual_match/src/provider/Event/ApiUpdate.dart';
import 'package:virtual_match/src/provider/event/ApiDelete.dart';
import 'package:rxdart/rxdart.dart';

import 'package:virtual_match/src/model/entity/IEntity.dart';
import 'package:virtual_match/src/provider/event/ApiAdd.dart';
import 'package:virtual_match/src/bloc/util/validator.dart';

class CommentBloc with Validators {
  final _controller = new BehaviorSubject<List<EventModel>>();
  final _loadingController = new BehaviorSubject<bool>();
  final _apiAdd = new ApiAddEvent();
  final _apiDelete = new ApiDeleteEvent();
  final _apiUpdate = new ApiUpdateEvent();

  Stream<List<EventModel>> get eventStream => _controller.stream;
  Stream<bool> get loading => _loadingController.stream;

  void getAll() async {
    // final Commentos = await _CommentosProvider.cargarCommentos();
    // _CommentosController.sink.add(Commentos);
  }

  Future<Map<String, dynamic>> repository(IEntityMap entity) async {
    var result;

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
