class User {
  final String id;
  final String username;
  final String email;
  final String password;

  const User({
    this.id = '',
    required this.username,
    required this.email,
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      id: json['id'],
      email: json['email'],
    );
  }

  factory User.fromRTDB(Map<dynamic, dynamic> data, String uid) {
    return User(
      id: uid,
      email: data['email'] ?? '',
      username: data['username'],
    );
  }

  // Para guardar en Realtime Database
  Map<String, dynamic> toRTDB() {
    return {
      'email': email,
      'username': username,
    };
  }
}
