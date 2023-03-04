import 'package:meta/meta.dart';
import 'package:timeout/src/constants.dart';
import 'package:timeout/src/snapshot.dart';

@immutable
class Range {
  final Snapshot initialDate;
  final Snapshot endDate;

  const Range(
    this.initialDate,
    this.endDate,
  );

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
}
