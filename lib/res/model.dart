class Model {
  final String? name;
  final String? tital;
  final String? thumbnail;
  final List<String>? allimages;

  Model({this.name, this.thumbnail, this.allimages , this.tital});

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      name: map['name'] as String?,
      tital: map['tital'] as String?,
      thumbnail: map['thumbnail'] as String?,
      allimages: List<String>.from(map['allimages'] as List),
    );
  }
}

