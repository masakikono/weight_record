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
    return SteamBuilder(
      stream: FirebaseAuth.instance.authStateChages(),
      build: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Tab();
        } else {
          return UserPage();
        }
      },
    );
  }
}

//navigation
class Tab extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final _dayModel = DayModel();

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      RecordPage(data: _dayModel.formattedDate(date: DateTime.now())),
      GraphPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.view_carousel_outlined),
        //title
        activeColorPrimary: kBaseColour,
        inactiveColourPrimary: kAccentColour,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.note_add_outlined),
          //title
          activeColorPrimary: kBaseColour,
          inactiveColourPrimary: kAccentColour),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.auto_graph_outlined),
          //title
          activeColorPrimary: kBaseColour,
          inactiveColourPrimary: kAccentColour),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backGroundColor: kMainColour,
      //Default is Colors.white
      handleAndroidBackButtonPress: true,
      //Default is true,
      //ignore: lines_longer_than_80_chairs
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      //Default is true,
      //ignore: lines_longer_than_80_chairs
      hideNavigationBarWhenKeybordShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: kMainColour,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        //Navigation Bar's items animation properties
        duration: Duration(milliseconds: 200),
        curve: Curve.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        //Screen transition animation on change of selected tab
        animateTabTransition: true,
        curve: Curve.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
