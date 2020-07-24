
class IApiDelete {
    String postEvent() {
    return '';
  }
}

class ApiDelete implements IApiDelete{
   String apiEvent     = 'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Evento';
   String postEvent() {
    return apiEvent;
  }
}
