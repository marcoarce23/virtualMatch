

class IApiAdd {
  String postEvent() {
    return '';
  }
}

class RouteAdd implements IApiAdd {

 String apiEvent     = 'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Evento';
 String apiMultimedy = 'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/Multimedia';

  String postEvent() {
    return apiEvent;
  }
}
