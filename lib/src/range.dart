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
        initialDate: Snapshot.fromMap(map['initialDate']),
        endDate: Snapshot.fromMap(map['endDate']),
      );
    } catch (err) {
      throw Exception('Invalid map: $err');
    }
  }

  factory Range.fromJson(String source) {
    try {
      final map = json.decode(source) as Map<String, dynamic>;

      final initialDate = Snapshot.fromMap(map['initialDate']);
      final endDate = Snapshot.fromMap(map['endDate']);

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

  bool includes(Snapshot snapshot) {
    return _isWhitinBounds(initialDate.year, endDate.year, snapshot.year) &&
        _isWhitinBounds(initialDate.month, endDate.month, snapshot.month) &&
        _isWhitinBounds(initialDate.day, endDate.day, snapshot.day) &&
        _isWhitinBounds(initialDate.hour, endDate.hour, snapshot.hour) &&
        _isWhitinBounds(initialDate.minute, endDate.minute, snapshot.minute) &&
        _isWhitinBounds(initialDate.second, endDate.second, snapshot.second) &&
        _isWhitinBounds(
            initialDate.millisecond, endDate.millisecond, snapshot.millisecond);
  }

  bool cross(Range range) {
    final left = initialDate.epochTime;
    final right = endDate.epochTime;
    final otherLeft = range.initialDate.epochTime;
    final otherRight = range.endDate.epochTime;
    return (left <= otherRight) && (right >= otherLeft);
  }

  bool contains(Range range) {
    return initialDate.epochTime <= range.initialDate.epochTime &&
        endDate.epochTime >= range.endDate.epochTime;
  }

  Range rangeDifference(Range range) {
    // If the given range is completely outside of this range, return this range
    if (range.endDate.epochTime <= initialDate.epochTime ||
        range.initialDate.epochTime >= endDate.epochTime) {
      return this;
    }

    // If the given range is completely inside of this range, split this range
    // into two parts and return the parts outside of the given range.
    if (range.initialDate.epochTime >= initialDate.epochTime &&
        range.endDate.epochTime <= endDate.epochTime) {
      final leftRange = Range(
        initialDate: initialDate,
        endDate: range.initialDate,
      );
      final rightRange = Range(
        initialDate: range.endDate,
        endDate: endDate,
      );
      if (leftRange.difference.inMilliseconds <
          rightRange.difference.inMilliseconds) {
        return leftRange;
      } else {
        return rightRange;
      }
    }

    // If the given range overlaps with this range, return the part of this
    // range that does not overlap with the given range.
    if (range.initialDate.epochTime < initialDate.epochTime &&
        range.endDate.epochTime > initialDate.epochTime &&
        range.endDate.epochTime < endDate.epochTime) {
      return Range(
        initialDate: range.endDate,
        endDate: endDate,
      );
    }
    if (range.initialDate.epochTime > initialDate.epochTime &&
        range.initialDate.epochTime < endDate.epochTime &&
        range.endDate.epochTime > endDate.epochTime) {
      return Range(
        initialDate: initialDate,
        endDate: range.initialDate,
      );
    }

    throw Exception('Unexpected case in rangeDifference() method');
  }

  bool _isWhitinBounds(int lowerBound, int upperBound, int value) {
    return (value >= lowerBound) && (value <= upperBound);
  }

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

  @override
  bool operator ==(Object other) {
    return other is Range &&
        initialDate == other.initialDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode {
    return initialDate.hashCode ^ endDate.hashCode;
  }
}
