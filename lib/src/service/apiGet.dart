

class IApiGet {
  static List getEvent() {
    return [];
  }
}

class ApiGet implements IApiGet {

 String url                 = 'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Eventos/';
 String getPrimaryKey = '_DevuelveEventosResult';

  List getEvent() {
    List _event = [getPrimaryKey, url];
    return _event;
  }
}
