import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:timeout/src/constants.dart';
import 'package:timeout/src/snapshot.dart';

@immutable
class Range {
  final Snapshot initialDate;
  final Snapshot endDate;

  const Range({
    required this.initialDate,
    required this.endDate,
  });

  factory Range.fromMap(Map<String, dynamic> map) {
    try {
      return Range(
        initialDate: map['initialDate'] as Snapshot,
        endDate: map['endDate'] as Snapshot,
      );
    } catch (err) {
      throw Exception('Invalid map: $err');
    }
  }

  factory Range.fromJson(String source) {
    try {
      final map = json.decode(source) as Map<String, dynamic>;

      final initialDate = map['initialDate'] as Snapshot?;
      final endDate = map['endDate'] as Snapshot?;

      if (initialDate == null) {
        throw Exception("Missing initialDate field.");
      }
      if (endDate == null) {
        throw Exception("Missing endDate field.");
      }

      return Range(
        initialDate: initialDate,
        endDate: endDate,
      );
    } catch (err) {
      throw Exception('Invalid JSON string: $err');
    }
  }

  // Getters for difference between initial and end dates
  int get differenceInEpoch => endDate.epochTime - initialDate.epochTime;
  int get differenceInMilliseconds => differenceInEpoch;
  int get differenceInSeconds => differenceInMilliseconds ~/ 1000;
  int get differenceInMinutes => differenceInSeconds ~/ 60;
  int get differenceInHours => differenceInMinutes ~/ 60;
  int get differenceInDays => differenceInHours ~/ 24;
  int get differenceInWeeks => differenceInDays ~/ 7;

  Duration get difference => _calculdateDifferece(initialDate, endDate);

  Duration _calculdateDifferece(Snapshot intial, Snapshot end) {
    final dEpoch = end.epochTime - intial.epochTime;
    int remainder = 0;

    // Calculate entire days with remainder
    final days = dEpoch ~/ TimeConstants.millisecondsInDay;
    remainder = dEpoch - (TimeConstants.millisecondsInDay * days);

    // Calculate entire hours with remainder
    final hours = remainder ~/ TimeConstants.millisecondsInHour;
    remainder = remainder - (TimeConstants.millisecondsInHour * hours);

    // Calculate entire minutes with remainder
    final minutes = remainder ~/ TimeConstants.millisecondsInMinute;
    remainder = remainder - (TimeConstants.millisecondsInMinute * minutes);

    // Calculate entire seconds with remainder
    final seconds = remainder ~/ TimeConstants.millisecondsInSecond;
    remainder = remainder - (TimeConstants.millisecondsInSecond * seconds);

    // Remaining milliseconds
    final milliseconds = remainder;

    return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  Range copyWith({
    Snapshot? initialDate,
    Snapshot? endDate,
  }) =>
      Range(
        initialDate: initialDate ?? this.initialDate,
        endDate: endDate ?? this.endDate,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'initialDate': initialDate.toMap(),
      'endDate': endDate.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
