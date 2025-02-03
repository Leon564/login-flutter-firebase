class UserModel {
  final String id;
  final String username;
  final String email;
  //final String password;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    //required this.password,
  });

  factory UserModel.fromRTDB(Map<dynamic, dynamic> data, String uid) {
    return UserModel(
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
