import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/model/viewmodel/chartmodel.dart';

Map<String, double> sampleDara = {
  DateTime.now().day.toString() + '日' : 80.0,
  (DateTime.now().day - 1).toString() + '日' : 30.0,
  (DateTime.now().day - 2).toString() + '日' : 10.0,
  (DateTime.now().day - 3).toString() + '日' : 5.0,
  (DateTime.now().day - 4).toString() + '日' : 5.0,
  (DateTime.now().day - 5).toString() + '日' : 15.0,
  (DateTime.now().day - 6).toString() + '日' : 20.0,
  (DateTime.now().day - 7).toString() + '日' : 3.0,
  (DateTime.now().day - 8).toString() + '日' : 5.0,
};

