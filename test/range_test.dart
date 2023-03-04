import 'package:flutter_test/flutter_test.dart';
import 'package:timeout/src/snapshot.dart';
import 'package:timeout/src/range.dart';

void main() {
  group('Range difference getters', () {
    final initialDate = Snapshot(
        year: 2022,
        month: 12,
        day: 20,
        hour: 19,
        minute: 35,
        second: 2,
        millisecond: 134);
    final endDate = Snapshot(
        year: 2023,
        month: 1,
        day: 4,
        hour: 8,
        minute: 26,
        second: 6,
        millisecond: 675);
    final range = Range(initialDate, endDate);

    test('Should return the difference in epoch', () {
      // Difference in Epoch is in milliseconds
      expect(range.differenceInEpoch, equals(1255864541));
    });

    test('Should return the difference in milliseconds', () {
      // Difference in Epoch == Difference in milliseconds
      expect(range.differenceInMilliseconds, equals(1255864541));
    });

    test('Should return the difference in seconds', () {
      // Difference in seconds == milliseconds / 1000
      expect(range.differenceInSeconds, equals(1255864));
    });

    test('Should return the difference in minutes', () {
      // Difference in minutes == seconds / 60
      expect(range.differenceInMinutes, equals(20931));
    });

    test('Should return the difference in hours', () {
      // Difference in hours == minutes / 60
      expect(range.differenceInHours, equals(348));
    });

    test('Should return the difference in days', () {
      // Difference in days == hours / 24
      expect(range.differenceInDays, equals(14));
    });
  });
}
