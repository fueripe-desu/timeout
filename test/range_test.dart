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

  group('Range immutable data class methods', () {
    final initialDate =
        Snapshot.fromDateTime(DateTime(2022, 12, 20, 7, 35, 38, 930));
    final endDate =
        Snapshot.fromDateTime(DateTime(2023, 1, 4, 16, 26, 13, 246));

    final range = Range(initialDate: initialDate, endDate: endDate);

    test('toJson() returns expected JSON string', () {
      const expectedJson =
          '{"initialDate":{"millisecond":930,"second":38,"minute":35,"hour":7,"day":20,"month":12,"year":2022},"endDate":{"millisecond":246,"second":13,"minute":26,"hour":16,"day":4,"month":1,"year":2023}}';

      expect(range.toJson(), equals(expectedJson));
    });

    test('toMap() returns expected map', () {
      final expectedMap = {
        'initialDate': {
          "millisecond": 930,
          "second": 38,
          "minute": 35,
          "hour": 7,
          "day": 20,
          "month": 12,
          "year": 2022
        },
        'endDate': {
          "millisecond": 246,
          "second": 13,
          "minute": 26,
          "hour": 16,
          "day": 4,
          "month": 1,
          "year": 2023
        },
      };

      expect(range.toMap(), equals(expectedMap));
    });

    test('copyWith() returns expected Range object', () {
      final newInitialDate = Snapshot.fromDateTime(DateTime(2021, 1, 1));
      final newRange = range.copyWith(initialDate: newInitialDate);

      expect(newRange.initialDate, equals(newInitialDate));
      expect(newRange.endDate, equals(endDate));
    });

    test('fromMap() returns expected Range object', () {
      final map = {
        'initialDate': {
          "millisecond": 930,
          "second": 38,
          "minute": 35,
          "hour": 7,
          "day": 20,
          "month": 12,
          "year": 2022
        },
        'endDate': {
          "millisecond": 246,
          "second": 13,
          "minute": 26,
          "hour": 16,
          "day": 4,
          "month": 1,
          "year": 2023
        },
      };

      final expectedRange = Range(initialDate: initialDate, endDate: endDate);

      expect(Range.fromMap(map), equals(expectedRange));
    });

    test('fromJson() returns expected Range object', () {
      const jsonStr =
          '{"initialDate":{"millisecond":930,"second":38,"minute":35,"hour":7,"day":20,"month":12,"year":2022},"endDate":{"millisecond":246,"second":13,"minute":26,"hour":16,"day":4,"month":1,"year":2023}}';

      final expectedRange = Range(initialDate: initialDate, endDate: endDate);

      expect(Range.fromJson(jsonStr), equals(expectedRange));
    });
  });

  group('Range includes() method', () {
    final range = Range(
      initialDate:
          Snapshot.fromDateTime(DateTime(2022, 01, 01, 12, 00, 00, 00)),
      endDate: Snapshot.fromDateTime(DateTime(2022, 01, 10, 12, 00, 00, 00)),
    );

    test('Should return true when the Snapshot is within the range', () {
      final snapshot =
          Snapshot.fromDateTime(DateTime(2022, 01, 05, 12, 00, 00, 00));
      expect(range.includes(snapshot), isTrue);
    });

    test('Should return false when the Snapshot is before the range', () {
      final snapshot =
          Snapshot.fromDateTime(DateTime(2021, 12, 31, 12, 00, 00, 00));
      expect(range.includes(snapshot), isFalse);
    });

    test('Should return false when the Snapshot is after the range', () {
      final snapshot =
          Snapshot.fromDateTime(DateTime(2022, 01, 12, 12, 00, 00, 00));
      expect(range.includes(snapshot), isFalse);
    });

    test('Should return true when the Snapshot is at the start of the range',
        () {
      final snapshot = range.initialDate;
      expect(range.includes(snapshot), isTrue);
    });

    test('Should return true when the Snapshot is at the end of the range', () {
      final snapshot = range.endDate;
      expect(range.includes(snapshot), isTrue);
    });

    test(
        'Should return true when the Snapshot has the same date/time components as the start of the range',
        () {
      final snapshot =
          Snapshot.fromDateTime(DateTime(2022, 01, 01, 12, 00, 00, 00));
      expect(range.includes(snapshot), isTrue);
    });

    test(
        'Should return true when the Snapshot has the same date/time components as the end of the range',
        () {
      final snapshot =
          Snapshot.fromDateTime(DateTime(2022, 01, 10, 12, 00, 00, 00));
      expect(range.includes(snapshot), isTrue);
    });
  });

  group("Range cross() method", () {
    test('should return true if ranges overlap', () {
      final range1 = Range(
        initialDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 9,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 11,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
      );

      final range2 = Range(
        initialDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 10,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
      );

      expect(range1.cross(range2), isTrue);
    });

    test('should return false if ranges do not overlap', () {
      final range1 = Range(
        initialDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 9,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 10,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
      );

      final range2 = Range(
        initialDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 11,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2022,
          month: 3,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
      );

      expect(range1.cross(range2), isFalse);
    });

    test('cross should return true if ranges have the same start and end dates',
        () {
      final snapshot = Snapshot(
          year: 2022, month: 4, day: 15, hour: 15, minute: 0, second: 0);
      final range1 = Range(initialDate: snapshot, endDate: snapshot);
      final range2 = Range(initialDate: snapshot, endDate: snapshot);
      expect(range1.cross(range2), isTrue);
    });
  });

  group("Range contains() method", () {
    final initialDate = Snapshot(
      year: 2021,
      month: 1,
      day: 1,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );
    final endDate = Snapshot(
      year: 2021,
      month: 1,
      day: 31,
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );
    final range = Range(initialDate: initialDate, endDate: endDate);
    test('should return true if given range is inside', () {
      final insideRange = Range(
        initialDate: Snapshot(
          year: 2021,
          month: 1,
          day: 10,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2021,
          month: 1,
          day: 20,
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
        ),
      );

      final result = range.contains(insideRange);

      expect(result, isTrue);
    });

    test('should return true if given range is equal', () {
      final equalRange = Range(
        initialDate: Snapshot(
          year: 2021,
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2021,
          month: 1,
          day: 31,
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
        ),
      );

      final result = range.contains(equalRange);

      expect(result, isTrue);
    });

    test('should return false if given range is partially outside', () {
      final partialRange = Range(
        initialDate: Snapshot(
          year: 2021,
          month: 1,
          day: 10,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2021,
          month: 2,
          day: 10,
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
        ),
      );

      final result = range.contains(partialRange);

      expect(result, isFalse);
    });

    test('should return false if given range is completely outside', () {
      final outsideRange = Range(
        initialDate: Snapshot(
          year: 2021,
          month: 2,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        ),
        endDate: Snapshot(
          year: 2021,
          month: 2,
          day: 28,
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
        ),
      );

      final result = range.contains(outsideRange);

      expect(result, isFalse);
    });

    test(
        'should return true if given range is same date as initialDate and endDate',
        () {
      final range = Range(
        initialDate: Snapshot(year: 2022, month: 04, day: 12),
        endDate: Snapshot(year: 2022, month: 04, day: 12),
      );

      final containedRange = Range(
        initialDate: Snapshot(year: 2022, month: 04, day: 12),
        endDate: Snapshot(year: 2022, month: 04, day: 12),
      );

      expect(range.contains(containedRange), isTrue);
    });
  });

  group('Range rangeDifference() method', () {
    test(
        'rangeDifference should return the entire range when the input range is completely outside of this range',
        () {
      final initialDate = Snapshot(year: 2021, month: 1, day: 1);
      final endDate = Snapshot(year: 2021, month: 2, day: 1);
      final range = Range(initialDate: initialDate, endDate: endDate);

      final otherInitialDate = Snapshot(year: 2021, month: 3, day: 1);
      final otherEndDate = Snapshot(year: 2021, month: 4, day: 1);
      final otherRange =
          Range(initialDate: otherInitialDate, endDate: otherEndDate);

      final result = range.rangeDifference(otherRange);

      expect(result.initialDate, equals(initialDate));
      expect(result.endDate, equals(endDate));
    });

    test(
        'rangeDifference should split the range into two parts when the input range is completely inside of this range',
        () {
      final initialDate = Snapshot(year: 2023, month: 4, day: 1);
      final endDate = Snapshot(year: 2023, month: 4, day: 15);
      final range = Range(initialDate: initialDate, endDate: endDate);
      final innerInitialDate = Snapshot(year: 2023, month: 4, day: 4);
      final innerEndDate = Snapshot(year: 2023, month: 4, day: 10);
      final innerRange =
          Range(initialDate: innerInitialDate, endDate: innerEndDate);
      final result = range.rangeDifference(innerRange);
      expect(result, isNotNull);
      expect(result.initialDate, equals(initialDate));
      expect(result.endDate, equals(innerInitialDate));
    });

    test(
        'rangeDifference should return the right part of the range when the input range overlaps on the left',
        () {
      final initialDate = Snapshot(year: 2021, month: 1, day: 1);
      final endDate = Snapshot(year: 2021, month: 3, day: 1);
      final range = Range(initialDate: initialDate, endDate: endDate);

      final otherInitialDate = Snapshot(year: 2020, month: 12, day: 15);
      final otherEndDate = Snapshot(year: 2021, month: 1, day: 15);
      final otherRange =
          Range(initialDate: otherInitialDate, endDate: otherEndDate);

      final result = range.rangeDifference(otherRange);

      expect(result.initialDate, equals(otherEndDate));
      expect(result.endDate, equals(endDate));
    });

    test(
        'rangeDifference should return the left part of the range when the input range overlaps on the right',
        () {
      final initialDate = Snapshot(year: 2021, month: 1, day: 1);
      final endDate = Snapshot(year: 2021, month: 3, day: 1);
      final range = Range(initialDate: initialDate, endDate: endDate);

      final otherInitialDate = Snapshot(year: 2021, month: 2, day: 15);
      final otherEndDate = Snapshot(year: 2021, month: 4, day: 1);
      final otherRange =
          Range(initialDate: otherInitialDate, endDate: otherEndDate);

      final result = range.rangeDifference(otherRange);

      expect(result.initialDate, equals(initialDate));
      expect(result.endDate, equals(otherInitialDate));
    });
  });
}
