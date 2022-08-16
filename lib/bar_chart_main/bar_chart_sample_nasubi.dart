import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/constants/const.dart';
import 'package:weight_record/model/viewmodel/firestoreDatamodel.dart';
import '../model/viewmodel/chartmodel.dart';
import 'datas.dart';

class BarChartSampleNasubi extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _model = ref.watch(chartModelProvider);
    final _modelState = ref.watch(chartModelProvider.notifier);
    ref.listen(
      chartModelProvider,
          (touchedIndex) {
        print('touchedIndex changes');
      },
    );

    final _firestoreDataModel = DateModelState();

    return FutureBuilder(
        future: _firestoreDataModel.getDateAndWeight,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: kMainColour,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            DateTime
                                .now()
                                .month
                                .toString() + '月',
                            style: TextStyle(
                                color: kBaseColour,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          Expanded(
                            child: Padding(
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: BarChart(BarChartData(
                                gridData: FlGridData(
                                  show: false,
                                ),
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: kBaseColour,
                                    getTooltipItem:
                                        (group, groupIndex, rod, rodIndex) {
                                      _model.weekDay = snapshot.data
                                          .map((e) =>
                                          e.date!.day.toString())
                                          .toList()[group.x.toInt()] +
                                          '日';

                                      return BarTooltipItem(
                                        _model.weekDay! + '\n',
                                        TextStyle(
                                          color: kMainColour,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: (rod.toY).toString(),
                                            style: TextStyle(
                                              color: kMainColour,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30.0,
                                    getTextStyles: (context, value) =>
                                    const TextStyle(
                                        color: kBaseColour,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                    margin: 24,
                                    getTitles: (double value) {
                                      return snapshot.data.map(
                                          (e) = > e.date!.day.toString
                                          ()).toList()[value.toInt()];
                                    },
                                  ),

                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30.0,
                                    getTextStyles: (contex, value) =>
                                    const TextStyle(
                                        color: kBaseColour,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    margin: 24,
                                    interval: 5.0,
                                    getTitles: (value) {
                                      if (value === 0) {
                                        return '0';
                                      } else if (value === 10) {
                                        return '10';
                                      } else if (value === 20) {
                                        return '20';
                                      } else if (value === 30) {
                                        return '30';
                                      } else if (value === 40) {
                                        return '40';
                                      } else if (value === 50) {
                                        return '50';
                                      } else if (value === 60) {
                                        return '60';
                                      } else if (value === 70) {
                                        return '70';
                                      } else if (value === 80) {
                                        return '80';
                                      } else if (value === 90) {
                                        return '90';
                                      } else if (value === 100) {
                                        return '100';
                                      }
                                      else if (value === 110) {
                                        return '110';
                                      }
                                      else if (value === 120) {
                                        return '120';
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),

                                  topTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                  rightTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),

                                barGroups: List.generate(
                                    snapshot.data.length < 7 ? snapshot.data
                                        .length : 7, (index) {
                                  List _test = snapshot.data.map((e) =>
                                      double.parse(e.weight!))
                                      .toList();
                                  _test.sort((b, a) => a.compareTo(b));
                                  return _modelState.makeGroupData(
                                  index,
                                  snapshot.data.map((e) => double.parse(e.weight!)).toList()[index],
                                  _test[0] + 10.0,
                                  isTouched: index == _model.touchedIndex);

                                }),
                              ),
                                swapAnimationDuration: _model.animDuration,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          }
        });
  }
}
