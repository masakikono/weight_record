import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/constants/const.dart';
import 'package:weight_record/model/viewmodel/firestoreDatamodel.dart';
import 'package:weight_record/model/viewmodel/addmodel.dart';
import 'package:weight_record/model/viewmodel/bmimodel.dart';
import 'package:weight_record/model/symplemodel/loginmodel.dart';

class RecordPage extends HookConsumerWidget {
  RecordPage({required this.date});

  String date;
  String weight = '';
  String height = '';
  String memo = '';
  double bmi = 0.0;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final _addController = ref.watch(userInfoModelProvider.notifier);
   final _bmiController = BmiModel();
   final_fireStoreDataController = ref.watch(firestoreDataModelProvider);


  }
}
