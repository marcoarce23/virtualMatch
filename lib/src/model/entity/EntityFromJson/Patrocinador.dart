import 'package:virtual_match/src/model/entity/IEntity.dart';

class Patrocinador implements IEntityJson {
  String url;

  Patrocinador({this.url});

  fromJson(Map<String, dynamic> json) => new Patrocinador(
        url: json["url"],
      );
}
