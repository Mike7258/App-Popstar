class Cast {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Nombre Desconocido',
      character: json['character'] ?? 'Personaje Desconocido',
      profilePath: json['profile_path'] ?? '',
    );
  }
}