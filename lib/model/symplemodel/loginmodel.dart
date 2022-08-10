import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_record/objects/userdata.dart';

class LoginModel {
  String? nickname;
  String? email;
  String? stringHeight;
  bool? isLoginLoading;
  bool? isUserLogin;
  String? uid;
  String exportedHeight = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserData? userData;

  Future signOut() async {
    await auth.signOut();
    userData = null;
  }

  Future<void> addUserName(
      {required nickname, required stringHeight, required email}) async {
    final _doc = firestore.collection('user').doc(email);
    await _doc.set({
      'nickname': nickname,
      'email': email,
      'height': stringHeight,
    });
  }

  String recordHeight({required height}) {
    exportedHeight = height;
    return exportedHeight;
  }

  void startLoginLoading() {
    isLoginLoading = true;
  }

  void endLoginLoading() {
    isLoginLoading = false;
  }

  Future<void> getUserData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('user').doc(email).get();
    userData = UserData(snapshot);
    print('-----------------------------user info get');
  }

  Future<UserData?> getUserDateReturn() async {
    final snapshot = await firestore.collection('user').doc(email).get();
    userData = UserData(snapshot);
    print('------------------------------user info get');
    return userData;
  }
}
