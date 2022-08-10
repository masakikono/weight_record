import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/constants/const.dart';

final chartModelProvider = StateNotifierProvider<ChartModelState, ChartModel>(
    (ref) => ChartModelState());

class ChartModel {
  final Color barBackgroundColor = kNuanceColour;
  final Duration animDuration = const Duration(milliseconds: 250);

  ChartModel({required int this.touchedIndex});

  int? touchedIndex;

  bool isPlaying = false;
  String? weekDay;
}

class ChartModelState extends StateNotifier<ChartModel> {
  ChartModelState() : super(ChartModel(touchedIndex: -1));

  BarChartGroupData makeGroupData(
    int x,
    double y,
    double maxWeight, {
    bool isTouched = false,
    Color barColor = kAccentColour,
    double width = 20.0,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? [Color.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: kAccentColour, width: 1)
              : BorderSide(color: kBaseColour, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxWeight,
            colors: [state.barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  void BarTouchResponse(barTouchResponse) {
    if (barTouchResponse.spot != null &&
        barTouchResponse.touchInput is! PointerUpEvent &&
        barTouchResponse.touchInput is! PointerExitEvent) {
      state =
          ChartModel(touchedIndex: barTouchResponse.spot!.touchedBarGroupIndex);
    } else {
      state = ChartModel(touchedIndex: -1);
    }
  }

  Future<dynamic> refreshState() async {
    await Future<dynamic>.delayed(
        state.animDuration + const Duration(milliseconds: 50));
    if (state.isPlaying) {
      await refreshState();
    }
  }
}
