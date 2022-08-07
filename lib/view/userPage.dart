import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/constants/const.dart';
import 'package:weight_record/model/symplemodel/loginmodel.dart';
import 'package:weight_record/model/viewmodel/addmodel.dart';

class UserPage extends HookConsumerWidget {
  String username = '';
  String height = '';
  String email = '';
  String password = '';

  final auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _emailntroller = TextEditingController();
  final _passwordController = TextEditingController();
  String exportedHeight = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginModel = LoginModel();
    final _addModelCOntroller = ref.read(userInfoModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: ,
      ),
    )
  }


}