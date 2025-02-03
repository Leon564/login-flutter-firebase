import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

// Clase abstracta
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> getUserData(String userId);
  Future<UserModel> signUp(String name, String email, String password);
  Future<void> signOut();
}

// Implementación concreta
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  Future<UserModel> signIn(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    // Imprimir el uid del usuario en la consola
    debugPrint("Usuario autenticado: ${user.user!.uid}");
    if (user.user != null) {
      final userData = await getUserInfo(user.user!.uid);
      return UserModel(
          id: user.user!.uid,
          username: userData.username,
          email: user.user!.email!);
    }

    throw Exception("Usuario no encontrado en la base de datos");
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //get user data
  @override
  Future<UserModel> getUserData(String userId) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await getUserInfo(userId);
      return UserModel(
          id: user.uid, username: userData.username, email: user.email!);
    }
    throw Exception("Usuario no encontrado en la base de datos");
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //save in realtime database the user name and email
    await saveUserInfo(user.user!.uid, name, email);
    return UserModel(
        id: user.user!.uid, username: name, email: user.user!.email!);
  }

  //save extra info in realtime database
  Future<void> saveUserInfo(
      String userId, String username, String email) async {
    await _databaseReference.child('users').child(userId).update({
      'username': username,
      'email': email,
      'createdAt': Timestamp.now().toString(),
      "summaries": {
        getMonthYearKey(DateTime.now()): {
          "totalBalance": 1200.50,
          "income": 5000.00,
          "expenses": 3800.50
        },
      },
      'transactions': [],
      'incomeCategories': [
        {'id': 1, 'name': 'salary', 'icon': 'payments'},
        {'id': 2, 'name': 'gift', 'icon': 'redeem'},
        {'id': 3, 'name': 'other', 'icon': 'question_exchange'},
      ],
      'expensesCategories': [
        {'id': 1, 'name': 'salary', 'icon': 'payments'},
        {'id': 2, 'name': 'rent', 'icon': 'home'},
        {'id': 3, 'name': 'food', 'icon': 'restaurant'},
        {'id': 4, 'name': 'transportation', 'icon': 'directions_car'},
        {'id': 5, 'name': 'entertainment', 'icon': 'movie'},
        {'id': 6, 'name': 'other', 'icon': 'question_exchange'},
      ],
    });
  }

  String getMonthYearKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}";
  }

  //get user info from realtime database
  Future<UserModel> getUserInfo(String userId) async {
    final user = _auth.currentUser;

    if (user != null) {
      final userDataRef =
          await _databaseReference.child('users').child(user.uid).once();
      DataSnapshot userData = await userDataRef.snapshot.ref.get();

      if (userData.exists) {
        return UserModel.fromRTDB(
            userData.value as Map<dynamic, dynamic>, user.uid);
      } else {
        throw Exception("Usuario no encontrado en la base de datos");
      }
    } else {
      throw Exception("Usuario no encontrado en la base de datos");
    }
  }
}
