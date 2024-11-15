import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    debugPrint(id);
    getUserData();
  }
  UserModel? currentUser;
  String? id;
  String? email;

  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  void saveUserData({
    required String id,
    required String email,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('email', email);
  }

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('id') == null) return;
    id = prefs.getString('id');
    email = prefs.getString('email');
    debugPrint(id);

    notifyListeners();
  }
}
