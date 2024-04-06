class User {
  User({
    required this.id, // Identificador único del usuario
    required this.username, // Nombre de usuario
    required this.email, // Correo electrónico del usuario
    required this.createdAt, // Fecha y hora de creación del usuario
    required this.updatedAt, // Fecha y hora de última actualización del usuario
    required this.avatar, // URL del avatar del usuario
  });

  final String id; // Identificador único del usuario
  final String username; // Nombre de usuario
  final String email; // Correo electrónico del usuario
  final DateTime createdAt; // Fecha y hora de creación del usuario
  final DateTime updatedAt; // Fecha y hora de última actualización del usuario
  final String avatar; // URL del avatar del usuario

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"], // Obtener el id del usuario del mapa JSON
        username: json["username"], // Obtener el nombre de usuario del mapa JSON
        email: json["email"], // Obtener el correo electrónico del mapa JSON
        createdAt: DateTime.parse(json["createdAt"]), // Convertir la cadena de fecha y hora en un objeto DateTime
        updatedAt: DateTime.parse(json["updatedAt"]), // Convertir la cadena de fecha y hora en un objeto DateTime
        avatar: json['avatar'], // Obtener la URL del avatar del mapa JSON
      );

  Map<String, dynamic> toJson() => {
        "_id": id, // Agregar el id al mapa JSON
        "username": username, // Agregar el nombre de usuario al mapa JSON
        "email": email, // Agregar el correo electrónico al mapa JSON
        "createdAt": createdAt.toIso8601String(), // Convertir la fecha y hora a una cadena ISO8601 y agregar al mapa JSON
        "updatedAt": updatedAt.toIso8601String(), // Convertir la fecha y hora a una cadena ISO8601 y agregar al mapa JSON
        "avatar": avatar, // Agregar la URL del avatar al mapa JSON
      };

  User copyWith({
    required String id,
    required String username,
    required String email,
    required String avatar,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) =>
      User(
        id: id, // Reemplazar el id del usuario
        username: username, // Reemplazar el nombre de usuario
        email: email, // Reemplazar el correo electrónico
        createdAt: createdAt, // Reemplazar la fecha y hora de creación
        updatedAt: updatedAt, // Reemplazar la fecha y hora de última actualización
        avatar: avatar, // Reemplazar la URL del avatar
      );
}
