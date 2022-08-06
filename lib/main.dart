import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:weight_record/constants/const.dart';
import 'package:weight_record/model/symplemodel/dayModel.dart';
import 'package:weight_record/view/graphPage.dart';
import 'package:weight_record/view/userPage.dart';

import 'view/homePage.dart';
import 'view/recordPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Record',
      home: MyHomePage(),
    );
  }
}

//initial page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SteamBuilder();
  }
}
