Map<String, List<String>> eventResource = {
  'add': ['http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Evento', ''],
  'getEvento': [
    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Eventos/',
    '_DevuelveEventosResult'
  ],
  'delete': [
    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/EliminarEvento/',
    ''
  ],
  'getListaEventos': [
    'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/ListaEventos',
    '_DevuelveListaEventosResult'
  ],

   'update': [
    '',
    ''
  ],
};

Map<String, List<String>> loginResource = {
  'getLogin': [
    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveLogin/',
    '_DevuelveLoginResult'
  ],
  'getToken': [
    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveTokens/',
    '_DevuelveTokenResult'
  ],
  'add': [
    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin1',
    ''
  ],
  'addTokenImei': [
    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/RegistrarDispositivo',
    ''
  ],
};

Map<String, List<String>> clasificadorResource = {
  'getClasificador': [
    'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/Clasificador/',
    '_DevuelveClasificadorResult'
  ],
  'getUbicacionesHabilitadas': [
    'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/DevuelveUbicacionesHabilitadas',
    '_DevuelveUbicacionesHabilitadasResult'
  ],
};

Map<String, List<String>> ayudaAmigoResource = {
  'getDevuelveAyudaAmigo': [
    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/DevuelveAyudas',
    '_DevuelveAyudasResult'
  ],
  'add': [
    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/AyudaAmigo',
    ''
  ],
};

Map<String, List<String>> institucionResource = {
  'getInstitucion': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucion/',
    '_DevuelveInstitucionesResult'
  ],
  'getInstitucionCreacion': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucionCreada/',
    '_DevuelveInstitucionesCreadaResult'
  ],
  'add': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/Institucion',
    ''
  ],
  'delete': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/EliminarInstitucion/',
    ''
  ],
  'getListaInstituciones': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveListaInstitucion',
    '_DevuelveListaInstitucionesResult'
  ],
};

Map<String, List<String>> voluntarioResource = {
  'getVoluntario': [
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelvePersonal/',
    '_DevuelvePersonalResult'
  ],
  'getVoluntarioPorInstitucion': [
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelveVoluntariosPorInstitucion/',
    'DevuelveVoluntariosPorInstitucionResult'
  ],
  'add': [
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/Personal',
    ''
  ],
  'aprobar': [
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/EstadoPersonal/',
    ''
  ],
  'delete': [
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/EliminarPersonal/',
    ''
  ],
  'getGrupoProfesionales': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveGrupoProfesionales',
    '_DevuelveGrupoProfesionalesResult'
  ],
  'getGrupoProfesionalesInstituciones': [
    'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelveListaProfesionalesInstitucion',
    '_DevuelveListaProfesionalesInstitucionResult'
  ],
  'getTodosGruposProfesionales': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveTodosGrupoProfesionales',
    '_DevuelveTodosGrupoProfesionalesResult'
  ],
};

Map<String, List<String>> atencionResource = {
  'getAtencion': [
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/DevuelveAtencion/{pIdInstitucion}/{pIdPersonal}',
    ''
  ],
  'add': [
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/Atencion',
    ''
  ],
  'addInstitucion': [
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/AtencionInstitucion',
    ''
  ],
  'getHorarioAtencionInstitucion': [
    'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveHorarioAtencion',
    '_DevuelveHorarioAtencionResult'
  ],
};

Map<String, List<String>> multimediaResource = {
  'getMultimedia': [
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimedias/',
    '_DevuelveListaMultimediaResult'
  ],
  'add': [
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/Multimedia',
    ''
  ],
  'delete': [
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/EliminarMultimedia/',
    ''
  ],
  'getListaMultimedia': [
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimedias',
    '_DevuelveListaMultimediaResult'
  ],
  'getListaMultimediaPorInstitucion': [
    'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/ListaMultimediasPorInstitucion',
    '_DevuelveListaMultimediaPorInstitucionResult'
  ],
};

Map<String, List<String>> contactosResource = {
  'getMultimedia': [
    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveContacto',
    '_DevuelveContactoResult'
  ],
};

Map<String, List<String>> emergenciaResource = {
  'getMultimedia': [
    'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/DevuelveEmergencia',
    '_DevuelveEmergencyResult'
  ],
};

Map<String, List<String>> botonPanicoResource = {
  'add': [
    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/BotonAyuda',
    ''
  ],
  'addSolicitud': [
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/SolicitudAyuda',
    ''
  ],
  'addSolicitudAyudaAmigo': [
    'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/SolicitudAyudaAmigo',
    ''
  ],
  'deleteAyudaAmigo': [
    'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/EliminarAyudaAmigo/',
    ''
  ],
  'getListaSolicitudes': [
    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/ListaSolicitudes',
    '_DevuelveListaSolicitudesResult'
  ],
  'getHistorialSolicitudes': [
    'http://covid19.ruta88.net/COVID/BotonPanico/srvBotonPanico.svc/HistorialListaSolicitudes',
    '_DevuelveHistorialListaSolicitudesResult'
  ],
};

/*
   Map<String, List<String>> productResource = {
    'add': ['urlAdd', 'keyResultAdd'],
    'delete': ['urldelete', 'keyResultDelete'],
    'update': ['urlupdate', 'keyResultUpdate'],
    'GetAll': ['urlgetall', 'keyResultGetAll']
  };
  */
