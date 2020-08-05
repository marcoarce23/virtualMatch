enum StateEntity { None, Insert, Update, Delete }

class IEntityMap {
  StateEntity _state;

  StateEntity get states => _state;

  void set states(StateEntity statesEntity) => this._state = statesEntity;

  Map<String, dynamic> toJson() => {};

  IEntityMap() {
    states = StateEntity.None;
  }
}

class IEntityJson {
  fromJson(Map<String, dynamic> json) => {};
}
