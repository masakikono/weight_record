import 'dart:math';

class BmiModel {
  double? bmi;
  double? weight;

  double? BmiCalc({required height, required weight}) {
    bmi = weight / pow(height * 0.01, 2);
    return bmi;
  }
}
