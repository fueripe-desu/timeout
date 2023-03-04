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
    final range = Range(initialDate: initialDate, endDate: endDate);

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

    test(
      "Should return the correct difference in Duration",
      () {
        final range1 = Range(
          initialDate: Snapshot(
            day: 20,
            month: 12,
            year: 2022,
            hour: 7,
            minute: 35,
            second: 27,
            millisecond: 765,
          ),
          endDate: Snapshot(
            day: 4,
            month: 1,
            year: 2023,
            hour: 16,
            minute: 26,
            second: 13,
            millisecond: 246,
          ),
        );

        expect(
          range1.difference,
          equals(
            const Duration(
                days: 15,
                hours: 8,
                minutes: 50,
                seconds: 45,
                milliseconds: 481),
          ),
        );
      },
    );
  });
}
