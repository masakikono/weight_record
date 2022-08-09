import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/constants/const.dart';
import 'package:weight_record/model/symplemodel/dayModel.dart';
import 'package:weight_record/model/viewmodel/calendarmodel.dart';
import 'package:weight_record/objects/record.dart';
import 'package:weight_record/view/recordPage.dart';

class CalendarPageView extends HookConsumerWidget {
  String _yearAndMonth = DayModel().getYearAndMonthString(date: DateTime.now());
}