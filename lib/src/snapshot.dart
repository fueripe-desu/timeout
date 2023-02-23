import 'package:meta/meta.dart';

// A Snapshot is an immutable point on time
@immutable
class Snapshot {
  final int millisecond;
  final int second;
  final int minute;
  final int hour;
  final int day;
  final int month;
  final int year;

  const Snapshot({
    this.millisecond = 0,
    this.second = 0,
    this.minute = 0,
    this.hour = 0,
    this.day = 1,
    this.month = 1,
    this.year = 1,
  });

  factory Snapshot.now() {
    final now = DateTime.now();

    return Snapshot(
      millisecond: now.millisecond,
      second: now.second,
      minute: now.minute,
      hour: now.hour,
      day: now.day,
      month: now.month,
      year: now.year,
    );
  }

  bool get isLeapYear => _isLeapYear(year);
  int get daysInMonth => _daysInMonth(month);

  bool _isLeapYear(int year) {
    return year % 4 == 0
        ? year % 100 == 0
            ? year % 400 == 0
                ? true
                : false
            : true
        : false;
  }

  int _daysInMonth(int month) {
    // February has 29 days in leap years and 28 days in normal years.
    if (month == 2) {
      if (_isLeapYear(year)) {
        return 29;
      } else {
        return 28;
      }
    }

    // April, June, September and November have all 30 days.
    if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }

    return 31;
  }

  Snapshot copyWith({
    int? millisecond,
    int? second,
    int? minute,
    int? hour,
    int? day,
    int? month,
    int? year,
  }) =>
      Snapshot(
        millisecond: millisecond ?? this.millisecond,
        second: second ?? this.second,
        minute: minute ?? this.minute,
        hour: hour ?? this.hour,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
      );

  @override
  bool operator ==(Object other) {
    return other is Snapshot &&
        millisecond == other.millisecond &&
        second == other.second &&
        minute == other.minute &&
        hour == other.hour &&
        day == other.day &&
        month == other.month &&
        year == other.year;
  }

  @override
  String toString() {
    final ms = millisecond.toString().padLeft(3, '0');
    final s = second.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');
    final hr = hour.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    final m = month.toString().padLeft(2, '0');
    final y = year.toString().padLeft(4, '0');

    return "$y-$m-$d $hr:$min:$s.$ms";
  }

  @override
  int get hashCode => super.hashCode;
}
