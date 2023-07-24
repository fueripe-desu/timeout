import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'snapshot_exceptions.dart';

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
  late final int epochTime;

  Snapshot({
    this.millisecond = 0,
    this.second = 0,
    this.minute = 0,
    this.hour = 0,
    this.day = 1,
    this.month = 1,
    this.year = 1,
  }) {
    try {
      if (year < 1 || year > 275760) {
        throw SnapshotDateError("Year must be between 1 and 275760.",
            InvalidDate(day, month, year, "year"),
            hint:
                "Try correcting the year passed to Snapshot() or Snapshot.copyWith() to a value in the accepted range");
      }

      if (month < 1 || month > 12) {
        throw SnapshotDateError("Month must be between 1 and 12.",
            InvalidDate(day, month, year, "month"),
            hint:
                "Try correcting the month passed to Snapshot() or Snapshot.copyWith() to a value between 1 and 12");
      }

      if (day < 1 || day > _daysInMonth(month, year)) {
        throw SnapshotDateError(
            "Days must be between 1 and ${_daysInMonth(month, year)}.",
            InvalidDate(day, month, year, "day"),
            hint:
                "Try correcting the day passed to Snapshot() or Snapshot.copyWith() to a value between 1 and ${_daysInMonth(month, year)}");
      }

      if (hour < 0 || hour > 23) {
        throw SnapshotTimeError(
          "Hours must be between 0 and 23.",
          InvalidTime(millisecond, second, minute, hour, "hour"),
          hint:
              "Try correcting the hour passed to Snapshot() or Snapshot.copyWith() to a value between 0 and 23",
        );
      }

      if (minute < 0 || minute > 59) {
        throw SnapshotTimeError(
          "Minutes must be between 0 and 59.",
          InvalidTime(millisecond, second, minute, hour, "minute"),
          hint:
              "Try correcting the minute passed to Snapshot() or Snapshot.copyWith() to a value between 0 and 59",
        );
      }

      if (second < 0 || second > 59) {
        throw SnapshotTimeError(
          "Seconds must be between 0 and 59.",
          InvalidTime(millisecond, second, minute, hour, "second"),
          hint:
              "Try correcting the second passed to Snapshot() or Snapshot.copyWith() to a value between 0 and 59",
        );
      }

      if (millisecond < 0 || millisecond > 999) {
        throw SnapshotTimeError(
          "Milliseconds must be between 0 and 999.",
          InvalidTime(millisecond, second, minute, hour, "millisecond"),
          hint:
              "Try correcting the millisecond passed to Snapshot() or Snapshot.copyWith() to a value between 0 and 999",
        );
      }

      // Sets epoch time
      epochTime = DateTime(
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
      ).toUtc().millisecondsSinceEpoch;
    } catch (err) {
      rethrow;
    }
  }

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

  factory Snapshot.fromDateTime(DateTime datetime) {
    return Snapshot(
      millisecond: datetime.millisecond,
      second: datetime.second,
      minute: datetime.minute,
      hour: datetime.hour,
      day: datetime.day,
      month: datetime.month,
      year: datetime.year,
    );
  }

  factory Snapshot.fromMap(Map<String, dynamic> map) {
    try {
      return Snapshot(
        millisecond: map['millisecond'] as int,
        second: map['second'] as int,
        minute: map['minute'] as int,
        hour: map['hour'] as int,
        day: map['day'] as int,
        month: map['month'] as int,
        year: map['year'] as int,
      );
    } catch (err) {
      throw SnapshotError('Invalid map: $err');
    }
  }

  factory Snapshot.fromJson(String source) {
    try {
      final map = json.decode(source) as Map<String, dynamic>;

      final millisecond = map['millisecond'] as int?;
      final second = map['second'] as int?;
      final minute = map['minute'] as int?;
      final hour = map['hour'] as int?;
      final day = map['day'] as int?;
      final month = map['month'] as int?;
      final year = map['year'] as int?;

      if (millisecond == null) {
        throw SnapshotError("Missing millisecond field.");
      }
      if (second == null) {
        throw SnapshotError("Missing second field.");
      }
      if (minute == null) {
        throw SnapshotError("Missing minute field.");
      }
      if (hour == null) {
        throw SnapshotError("Missing hour field.");
      }
      if (day == null) {
        throw SnapshotError("Missing day field.");
      }
      if (month == null) {
        throw SnapshotError("Missing month field.");
      }
      if (year == null) {
        throw SnapshotError("Missing year field.");
      }

      return Snapshot(
        millisecond: millisecond,
        second: second,
        minute: minute,
        hour: hour,
        day: day,
        month: month,
        year: year,
      );
    } catch (err) {
      throw SnapshotError('Invalid JSON string: $err');
    }
  }

  bool get isLeapYear => _isLeapYear(year);
  int get daysInMonth => _daysInMonth(month, year);

  Snapshot get endOfDay => Snapshot(
        year: year,
        month: month,
        day: day,
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 999,
      );

  bool _isLeapYear(int year) {
    return year % 4 == 0 && (!(year % 100 == 0) || year % 400 == 0);
  }

  int _daysInMonth(int month, int year) {
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'millisecond': millisecond,
      'second': second,
      'minute': minute,
      'hour': hour,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  String toJson() => json.encode(toMap());

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

  bool operator <(Object other) {
    return other is Snapshot &&
        millisecond < other.millisecond &&
        second < other.second &&
        minute < other.minute &&
        hour < other.hour &&
        day < other.day &&
        month < other.month &&
        year < other.year;
  }

  bool operator >(Object other) {
    return other is Snapshot &&
        millisecond > other.millisecond &&
        second > other.second &&
        minute > other.minute &&
        hour > other.hour &&
        day > other.day &&
        month > other.month &&
        year > other.year;
  }

  bool operator <=(Object other) {
    return other is Snapshot &&
        millisecond <= other.millisecond &&
        second <= other.second &&
        minute <= other.minute &&
        hour <= other.hour &&
        day <= other.day &&
        month <= other.month &&
        year <= other.year;
  }

  bool operator >=(Object other) {
    return other is Snapshot &&
        millisecond >= other.millisecond &&
        second >= other.second &&
        minute >= other.minute &&
        hour >= other.hour &&
        day >= other.day &&
        month >= other.month &&
        year >= other.year;
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
  int get hashCode {
    return millisecond.hashCode ^
        second.hashCode ^
        minute.hashCode ^
        hour.hashCode ^
        day.hashCode ^
        month.hashCode ^
        year.hashCode;
  }
}
