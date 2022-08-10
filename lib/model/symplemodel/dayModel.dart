import 'package:intl/intl.dart';

class DayModel {
  String formattedDate({required DateTime date}) {
    final _result = DateFormat('yyyy-MM-dd').format(date);
    return _result;
  }

  String getYearAndMonthString({required DateTime date}) {
    final _month = date.month;
    final _year = date.year;
    String _result = _year.toString() + '' + _month.toString();
    return _result;
  }
}
