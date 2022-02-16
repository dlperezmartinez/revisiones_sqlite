final String tableArneses = 'arneses';

class ArnesFields {
  static final List<String> values = [id, nombre, revision, observaciones];
  static final String id = '_id';
  static final String nombre = 'nombre';
  static final String revision = 'revision';
  static final String observaciones = 'observaciones';
}

class Arnes {
  final int? id;
  String nombre;
  DateTime revision;
  String observaciones;
  //Image foto;

  Arnes({
    this.id,
    required this.nombre,
    required this.revision,
    required this.observaciones,
  });

  static Arnes fromJson(Map<String, Object?> json) => Arnes(
        id: json[ArnesFields.id] as int?,
        nombre: json[ArnesFields.nombre] as String,
        revision: DateTime.parse(json[ArnesFields.revision] as String),
        observaciones: json[ArnesFields.observaciones] as String,
      );

  Map<String, Object?> toJson() => {
        ArnesFields.id: id,
        ArnesFields.nombre: nombre,
        ArnesFields.revision: revision.toIso8601String(),
        ArnesFields.observaciones: observaciones,
      };

  Arnes copy({
    //Lo que se supone que hace este método es copiar el objeto Arnes existente y pasarle los valores nuevos
    int? id,
    String? nombre,
    DateTime? revision,
    String? observaciones,
  }) =>
      Arnes(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        revision: revision ?? this.revision,
        observaciones: observaciones ?? this.observaciones,
      );
}
