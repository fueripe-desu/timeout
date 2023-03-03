import 'package:meta/meta.dart';
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
}
