import 'package:flutter_test/flutter_test.dart';

import 'package:timeout/timeout.dart';

void main() {
  group('Snapshot constructor', () {
    test('should create a snapshot with the provided date and time', () {
      final snapshot = Snapshot(
        millisecond: 123,
        second: 45,
        minute: 30,
        hour: 12,
        day: 25,
        month: 12,
        year: 2022,
      );
      expect(snapshot.millisecond, equals(123));
      expect(snapshot.second, equals(45));
      expect(snapshot.minute, equals(30));
      expect(snapshot.hour, equals(12));
      expect(snapshot.day, equals(25));
      expect(snapshot.month, equals(12));
      expect(snapshot.year, equals(2022));
    });

    test('should create a snapshot with default values if not provided', () {
      final snapshot = Snapshot();
      expect(snapshot.millisecond, equals(0));
      expect(snapshot.second, equals(0));
      expect(snapshot.minute, equals(0));
      expect(snapshot.hour, equals(0));
      expect(snapshot.day, equals(1));
      expect(snapshot.month, equals(1));
      expect(snapshot.year, equals(1));
    });

    test(
        'should throw an exception when creating snapshot with invalid date/time values',
        () {
      expect(() => Snapshot(year: 0), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(year: -2022), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(year: 275761), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(month: 0), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(month: 13), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(day: 0), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(day: 32), throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(day: 30, month: 2, year: 2024),
          throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(day: 30, month: 2, year: 2021),
          throwsA(isA<SnapshotDateError>()));
      expect(() => Snapshot(hour: -1), throwsA(isA<SnapshotTimeError>()));
      expect(() => Snapshot(hour: 24), throwsA(isA<SnapshotTimeError>()));
      expect(() => Snapshot(minute: -1), throwsA(isA<SnapshotTimeError>()));
      expect(() => Snapshot(minute: 60), throwsA(isA<SnapshotTimeError>()));
      expect(() => Snapshot(second: -1), throwsA(isA<SnapshotTimeError>()));
      expect(() => Snapshot(second: 60), throwsA(isA<SnapshotTimeError>()));
      expect(
          () => Snapshot(millisecond: -1), throwsA(isA<SnapshotTimeError>()));
      expect(
          () => Snapshot(millisecond: 1000), throwsA(isA<SnapshotTimeError>()));
    });
  });

  group("Snapshot now() factory", () {
    test('should create a snapshot with the current date and time', () {
      final now = DateTime.now();
      final snapshot = Snapshot(
        millisecond: now.millisecond,
        second: now.second,
        minute: now.minute,
        hour: now.hour,
        day: now.day,
        month: now.month,
        year: now.year,
      );
      expect(snapshot.millisecond, equals(now.millisecond));
      expect(snapshot.second, equals(now.second));
      expect(snapshot.minute, equals(now.minute));
      expect(snapshot.hour, equals(now.hour));
      expect(snapshot.day, equals(now.day));
      expect(snapshot.month, equals(now.month));
      expect(snapshot.year, equals(now.year));
    });
  });

  group("Snapshot copyWith() method", (() {
    test('should return a new Snapshot object with the updated fields', () {
      // Arrange
      final snapshot = Snapshot(
        millisecond: 123,
        second: 45,
        minute: 30,
        hour: 10,
        day: 22,
        month: 2,
        year: 2023,
      );

      // Act
      final updatedSnapshot = snapshot.copyWith(
        millisecond: 456,
        second: 15,
        minute: 0,
        hour: 12,
        day: 1,
        month: 1,
        year: 2024,
      );

      // Assert
      expect(updatedSnapshot.millisecond, equals(456));
      expect(updatedSnapshot.second, equals(15));
      expect(updatedSnapshot.minute, equals(0));
      expect(updatedSnapshot.hour, equals(12));
      expect(updatedSnapshot.day, equals(1));
      expect(updatedSnapshot.month, equals(1));
      expect(updatedSnapshot.year, equals(2024));
    });

    test('should return the original Snapshot object if no fields are updated',
        () {
      // Arrange
      final snapshot = Snapshot(
        millisecond: 123,
        second: 45,
        minute: 30,
        hour: 10,
        day: 22,
        month: 2,
        year: 2023,
      );

      // Act
      final updatedSnapshot = snapshot.copyWith();

      // Assert
      expect(updatedSnapshot, equals(snapshot));
    });

    test('should not modify the original Snapshot object', () {
      // Arrange
      final snapshot = Snapshot(
        millisecond: 123,
        second: 45,
        minute: 30,
        hour: 10,
        day: 22,
        month: 2,
        year: 2023,
      );

      // Act
      snapshot.copyWith(millisecond: 456);

      // Assert
      expect(snapshot.millisecond, equals(123));
    });

    test('should return a new Snapshot with updated year', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(year: 2012);
      expect(newSnapshot.year, equals(2012));
      expect(newSnapshot.month, equals(1));
      expect(newSnapshot.day, equals(1));
      expect(newSnapshot.hour, equals(12));
      expect(newSnapshot.minute, equals(0));
      expect(newSnapshot.second, equals(0));
      expect(newSnapshot.millisecond, equals(0));
    });

    test('should return a new Snapshot with updated month', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(month: 5);
      expect(newSnapshot.year, equals(2022));
      expect(newSnapshot.month, equals(5));
      expect(newSnapshot.day, equals(1));
      expect(newSnapshot.hour, equals(12));
      expect(newSnapshot.minute, equals(0));
      expect(newSnapshot.second, equals(0));
      expect(newSnapshot.millisecond, equals(0));
    });

    test('should return a new Snapshot with updated day', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(day: 19);
      expect(newSnapshot.year, equals(2022));
      expect(newSnapshot.month, equals(1));
      expect(newSnapshot.day, equals(19));
      expect(newSnapshot.hour, equals(12));
      expect(newSnapshot.minute, equals(0));
      expect(newSnapshot.second, equals(0));
      expect(newSnapshot.millisecond, equals(0));
    });

    test('should return a new Snapshot with updated hour', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(hour: 23);
      expect(newSnapshot.year, equals(2022));
      expect(newSnapshot.month, equals(1));
      expect(newSnapshot.day, equals(1));
      expect(newSnapshot.hour, equals(23));
      expect(newSnapshot.minute, equals(0));
      expect(newSnapshot.second, equals(0));
      expect(newSnapshot.millisecond, equals(0));
    });

    test('should return a new Snapshot with updated minute', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(minute: 59);
      expect(newSnapshot.year, equals(2022));
      expect(newSnapshot.month, equals(1));
      expect(newSnapshot.day, equals(1));
      expect(newSnapshot.hour, equals(12));
      expect(newSnapshot.minute, equals(59));
      expect(newSnapshot.second, equals(0));
      expect(newSnapshot.millisecond, equals(0));
    });

    test('should return a new Snapshot with updated second', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(second: 59);
      expect(newSnapshot.year, equals(2022));
      expect(newSnapshot.month, equals(1));
      expect(newSnapshot.day, equals(1));
      expect(newSnapshot.hour, equals(12));
      expect(newSnapshot.minute, equals(0));
      expect(newSnapshot.second, equals(59));
      expect(newSnapshot.millisecond, equals(0));
    });

    test('should return a new Snapshot with updated millisecond', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final newSnapshot = snapshot.copyWith(millisecond: 999);
      expect(newSnapshot.year, equals(2022));
      expect(newSnapshot.month, equals(1));
      expect(newSnapshot.day, equals(1));
      expect(newSnapshot.hour, equals(12));
      expect(newSnapshot.minute, equals(0));
      expect(newSnapshot.second, equals(0));
      expect(newSnapshot.millisecond, equals(999));
    });

    test('should return a new Snapshot with the same year if year is null', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(year: null);

      expect(updatedSnapshot.year, equals(snapshot.year));
    });

    test('should return a new Snapshot with the same month if month is null',
        () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(month: null);

      expect(updatedSnapshot.month, equals(snapshot.month));
    });

    test('should return a new Snapshot with the same day if day is null', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(day: null);

      expect(updatedSnapshot.day, equals(snapshot.day));
    });

    test('should return a new Snapshot with the same hour if hour is null', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(hour: null);

      expect(updatedSnapshot.hour, equals(snapshot.hour));
    });

    test('should return a new Snapshot with the same minute if minute is null',
        () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(minute: null);

      expect(updatedSnapshot.minute, equals(snapshot.minute));
    });

    test('should return a new Snapshot with the same second if second is null',
        () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(second: null);

      expect(updatedSnapshot.second, equals(snapshot.second));
    });

    test(
        'should return a new Snapshot with the same millisecond if millisecond is null',
        () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      final updatedSnapshot = snapshot.copyWith(millisecond: null);

      expect(updatedSnapshot.millisecond, equals(snapshot.millisecond));
    });

    test('should throw an Exception if year is less than 1', () {
      final snapshot = Snapshot(year: 2022, month: 1);
      expect(
          () => snapshot.copyWith(year: 0), throwsA(isA<SnapshotDateError>()));
      expect(
          () => snapshot.copyWith(year: -1), throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception if year is more than 275760', () {
      final snapshot = Snapshot(year: 2022, month: 1);
      expect(() => snapshot.copyWith(year: 275761),
          throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception if month is less than 1', () {
      final snapshot = Snapshot(year: 2022, month: 1);
      expect(
          () => snapshot.copyWith(month: 0), throwsA(isA<SnapshotDateError>()));
      expect(() => snapshot.copyWith(month: -1),
          throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception if month is more than 12', () {
      final snapshot = Snapshot(year: 2022, month: 1);
      expect(() => snapshot.copyWith(month: 13),
          throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception if day is less than 1', () {
      final snapshot = Snapshot(year: 2022, month: 1, day: 20);
      expect(
          () => snapshot.copyWith(day: 0), throwsA(isA<SnapshotDateError>()));
      expect(
          () => snapshot.copyWith(day: -1), throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception if day is more than 31', () {
      final snapshot = Snapshot(year: 2022, month: 1, day: 20);
      expect(
          () => snapshot.copyWith(day: 32), throwsA(isA<SnapshotDateError>()));
    });

    test(
        'should throw an Exception when trying to set invalid day in February of normal year',
        () {
      final snapshot = Snapshot(year: 2021, month: 2, day: 15);
      expect(
          () => snapshot.copyWith(day: 30), throwsA(isA<SnapshotDateError>()));
    });

    test(
        'should throw an Exception when trying to set invalid day in February of leap year',
        () {
      final snapshot = Snapshot(year: 2024, month: 2, day: 15);
      expect(
          () => snapshot.copyWith(day: 30), throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception when day is more than 30 in month April',
        () {
      final snapshot = Snapshot(year: 2022, month: 4, day: 15);
      expect(
          () => snapshot.copyWith(day: 31), throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception when day is more than 30 in month June',
        () {
      final snapshot = Snapshot(year: 2022, month: 6, day: 15);
      expect(
          () => snapshot.copyWith(day: 31), throwsA(isA<SnapshotDateError>()));
    });

    test(
        'should throw an Exception when day is more than 30 in month September',
        () {
      final snapshot = Snapshot(year: 2022, month: 9, day: 15);
      expect(
          () => snapshot.copyWith(day: 31), throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception when day is more than 30 in month November',
        () {
      final snapshot = Snapshot(year: 2022, month: 11, day: 15);
      expect(
          () => snapshot.copyWith(day: 31), throwsA(isA<SnapshotDateError>()));
    });

    test('should throw an Exception if hour is more than 23', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(
          () => snapshot.copyWith(hour: 24), throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if hour is negative', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(
          () => snapshot.copyWith(hour: -1), throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if minute is more than 59', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(() => snapshot.copyWith(minute: 60),
          throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if minute is negative', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(() => snapshot.copyWith(minute: -1),
          throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if second is more than 59', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(() => snapshot.copyWith(second: 60),
          throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if second is negative', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(() => snapshot.copyWith(second: -1),
          throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if millisecond is more than 999', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(() => snapshot.copyWith(millisecond: 1000),
          throwsA(isA<SnapshotTimeError>()));
    });

    test('should throw an Exception if millisecond is negative', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 1,
          day: 1,
          hour: 12,
          minute: 0,
          second: 0,
          millisecond: 0);
      expect(() => snapshot.copyWith(millisecond: -1),
          throwsA(isA<SnapshotTimeError>()));
    });
  }));

  group("Snapshot daysInMonth getter", () {
    test('should return 31 for January', () {
      final snapshot = Snapshot(year: 2022, month: 1);
      expect(snapshot.daysInMonth, 31);
    });

    test('should return 28 for February in a normal year', () {
      final snapshot = Snapshot(year: 2021, month: 2);
      expect(snapshot.daysInMonth, 28);
    });

    test('should return 29 for February in a leap year', () {
      final snapshot = Snapshot(year: 2024, month: 2);
      expect(snapshot.daysInMonth, 29);
    });

    test('should return 31 for March', () {
      final snapshot = Snapshot(year: 2022, month: 3);
      expect(snapshot.daysInMonth, 31);
    });

    test('should return 30 for April', () {
      final snapshot = Snapshot(year: 2022, month: 4);
      expect(snapshot.daysInMonth, 30);
    });

    test('should return 31 for May', () {
      final snapshot = Snapshot(year: 2022, month: 5);
      expect(snapshot.daysInMonth, 31);
    });

    test('should return 30 for June', () {
      final snapshot = Snapshot(year: 2022, month: 6);
      expect(snapshot.daysInMonth, 30);
    });

    test('should return 31 for July', () {
      final snapshot = Snapshot(year: 2022, month: 7);
      expect(snapshot.daysInMonth, 31);
    });

    test('should return 31 for August', () {
      final snapshot = Snapshot(year: 2022, month: 8);
      expect(snapshot.daysInMonth, 31);
    });

    test('should return 30 for September', () {
      final snapshot = Snapshot(year: 2022, month: 9);
      expect(snapshot.daysInMonth, 30);
    });

    test('should return 31 for October', () {
      final snapshot = Snapshot(year: 2022, month: 10);
      expect(snapshot.daysInMonth, 31);
    });

    test('should return 30 for November', () {
      final snapshot = Snapshot(year: 2022, month: 11);
      expect(snapshot.daysInMonth, 30);
    });

    test('should return 31 for December', () {
      final snapshot = Snapshot(year: 2022, month: 12);
      expect(snapshot.daysInMonth, 31);
    });
  });

  group("Snapshot isLeapYear getter", () {
    test('should return true for leap years', () {
      expect(Snapshot(year: 2020).isLeapYear, isTrue);
      expect(Snapshot(year: 2000).isLeapYear, isTrue);
      expect(Snapshot(year: 1600).isLeapYear, isTrue);
    });

    test('should return false for non-leap years', () {
      expect(Snapshot(year: 2021).isLeapYear, isFalse);
      expect(Snapshot(year: 1900).isLeapYear, isFalse);
      expect(Snapshot(year: 1700).isLeapYear, isFalse);
    });

    test('should return false for non-leap year divisible by 100', () {
      final snapshot = Snapshot(year: 1900);
      expect(snapshot.isLeapYear, isFalse);
    });

    test('should return true for leap year divisible by 4 but not by 100', () {
      final snapshot = Snapshot(year: 2024);
      expect(snapshot.isLeapYear, isTrue);
    });

    test('should return false for non-leap year not divisible by 4', () {
      final snapshot = Snapshot(year: 2023);
      expect(snapshot.isLeapYear, isFalse);
    });
  });

  group("Snapshot endOfDay getter", () {
    test('should return a Snapshot representing the end of the day', () {
      final snapshot = Snapshot(
        year: 2023,
        month: 7,
        day: 24,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      final endOfDaySnapshot = snapshot.endOfDay;

      expect(endOfDaySnapshot.year, 2023);
      expect(endOfDaySnapshot.month, 7);
      expect(endOfDaySnapshot.day, 24);
      expect(endOfDaySnapshot.hour, 23);
      expect(endOfDaySnapshot.minute, 59);
      expect(endOfDaySnapshot.second, 59);
      expect(endOfDaySnapshot.millisecond, 999);
    });
  });

  group('Snapshot endOfMonth getter', () {
    test('should return the end of February for a non-leap year', () {
      // Arrange
      final snapshot = Snapshot(
        year: 2023,
        month: 2,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      // Act
      final endOfMonthSnapshot = snapshot.endOfMonth;

      // Assert
      expect(endOfMonthSnapshot.year, 2023);
      expect(endOfMonthSnapshot.month, 2);
      expect(endOfMonthSnapshot.day, 28); // February 2023 has 28 days.
      expect(endOfMonthSnapshot.hour, 23);
      expect(endOfMonthSnapshot.minute, 59);
      expect(endOfMonthSnapshot.second, 59);
      expect(endOfMonthSnapshot.millisecond, 999);
    });

    test('should return the end of February for a leap year', () {
      // Arrange
      final snapshot = Snapshot(
        year: 2024,
        month: 2,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      // Act
      final endOfMonthSnapshot = snapshot.endOfMonth;

      // Assert
      expect(endOfMonthSnapshot.year, 2024);
      expect(endOfMonthSnapshot.month, 2);
      expect(endOfMonthSnapshot.day,
          29); // February 2024 is a leap year with 29 days.
      expect(endOfMonthSnapshot.hour, 23);
      expect(endOfMonthSnapshot.minute, 59);
      expect(endOfMonthSnapshot.second, 59);
      expect(endOfMonthSnapshot.millisecond, 999);
    });

    test('should return the end of April', () {
      // Arrange
      final snapshot = Snapshot(
        year: 2023,
        month: 4,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      // Act
      final endOfMonthSnapshot = snapshot.endOfMonth;

      // Assert
      expect(endOfMonthSnapshot.year, 2023);
      expect(endOfMonthSnapshot.month, 4);
      expect(endOfMonthSnapshot.day, 30); // April 2023 has 30 days.
      expect(endOfMonthSnapshot.hour, 23);
      expect(endOfMonthSnapshot.minute, 59);
      expect(endOfMonthSnapshot.second, 59);
      expect(endOfMonthSnapshot.millisecond, 999);
    });

    test('should return the end of June', () {
      // Arrange
      final snapshot = Snapshot(
        year: 2023,
        month: 6,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      // Act
      final endOfMonthSnapshot = snapshot.endOfMonth;

      // Assert
      expect(endOfMonthSnapshot.year, 2023);
      expect(endOfMonthSnapshot.month, 6);
      expect(endOfMonthSnapshot.day, 30); // June 2023 has 30 days.
      expect(endOfMonthSnapshot.hour, 23);
      expect(endOfMonthSnapshot.minute, 59);
      expect(endOfMonthSnapshot.second, 59);
      expect(endOfMonthSnapshot.millisecond, 999);
    });

    test('should return the end of September', () {
      // Arrange
      final snapshot = Snapshot(
        year: 2023,
        month: 9,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      // Act
      final endOfMonthSnapshot = snapshot.endOfMonth;

      // Assert
      expect(endOfMonthSnapshot.year, 2023);
      expect(endOfMonthSnapshot.month, 9);
      expect(endOfMonthSnapshot.day, 30); // September 2023 has 30 days.
      expect(endOfMonthSnapshot.hour, 23);
      expect(endOfMonthSnapshot.minute, 59);
      expect(endOfMonthSnapshot.second, 59);
      expect(endOfMonthSnapshot.millisecond, 999);
    });

    test('should return the end of November', () {
      // Arrange
      final snapshot = Snapshot(
        year: 2023,
        month: 11,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      // Act
      final endOfMonthSnapshot = snapshot.endOfMonth;

      // Assert
      expect(endOfMonthSnapshot.year, 2023);
      expect(endOfMonthSnapshot.month, 11);
      expect(endOfMonthSnapshot.day, 30); // November 2023 has 30 days.
      expect(endOfMonthSnapshot.hour, 23);
      expect(endOfMonthSnapshot.minute, 59);
      expect(endOfMonthSnapshot.second, 59);
      expect(endOfMonthSnapshot.millisecond, 999);
    });
  });

  group("Snapshot endOfHour getter", () {
    test('should return a Snapshot representing the end of the hour', () {
      final snapshot = Snapshot(
        year: 2023,
        month: 7,
        day: 24,
        hour: 15,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      final endOfHourSnapshot = snapshot.endOfHour;

      expect(endOfHourSnapshot.year, 2023);
      expect(endOfHourSnapshot.month, 7);
      expect(endOfHourSnapshot.day, 24);
      expect(endOfHourSnapshot.hour, 15);
      expect(endOfHourSnapshot.minute, 59);
      expect(endOfHourSnapshot.second, 59);
      expect(endOfHourSnapshot.millisecond, 999);
    });
  });

  group("Snapshot endOfMinute getter", () {
    test('should return a Snapshot representing the end of the minute', () {
      final snapshot = Snapshot(
        year: 2023,
        month: 7,
        day: 24,
        hour: 15,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      final endOfMinuteSnapshot = snapshot.endOfMinute;

      expect(endOfMinuteSnapshot.year, 2023);
      expect(endOfMinuteSnapshot.month, 7);
      expect(endOfMinuteSnapshot.day, 24);
      expect(endOfMinuteSnapshot.hour, 15);
      expect(endOfMinuteSnapshot.minute, 30);
      expect(endOfMinuteSnapshot.second, 59);
      expect(endOfMinuteSnapshot.millisecond, 999);
    });
  });

  group("Snapshot endOfSecond getter", () {
    test('should return a Snapshot representing the end of the second', () {
      final snapshot = Snapshot(
        year: 2023,
        month: 7,
        day: 24,
        hour: 15,
        minute: 30,
        second: 45,
        millisecond: 500,
      );

      final endOfSecondSnapshot = snapshot.endOfSecond;

      expect(endOfSecondSnapshot.year, 2023);
      expect(endOfSecondSnapshot.month, 7);
      expect(endOfSecondSnapshot.day, 24);
      expect(endOfSecondSnapshot.hour, 15);
      expect(endOfSecondSnapshot.minute, 30);
      expect(endOfSecondSnapshot.second, 45);
      expect(endOfSecondSnapshot.millisecond, 999);
    });
  });

  group("Snapshot hashCode method", () {
    test('should return the same hash code for equal Snapshots', () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, equals(snapshot2.hashCode));
    });

    test('should return different hash codes for Snapshots with different year',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2023,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });

    test(
        'should return different hash codes for Snapshots with different month',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 4,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });

    test('should return different hash codes for Snapshots with different day',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 3,
        day: 2,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });

    test('should return different hash codes for Snapshots with different hour',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 13,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });

    test(
        'should return different hash codes for Snapshots with different minute',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 31,
        second: 45,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });

    test(
        'should return different hash codes for Snapshots with different second',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 46,
        millisecond: 500,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });
    test(
        'should return different hash codes for Snapshots with different millisecond',
        () {
      final snapshot1 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final snapshot2 = Snapshot(
        year: 2022,
        month: 3,
        day: 1,
        hour: 12,
        minute: 30,
        second: 45,
        millisecond: 501,
      );
      expect(snapshot1.hashCode, isNot(snapshot2.hashCode));
    });
  });

  group("Snapshot toMap() method", () {
    test('should return a map with all snapshot values', () {
      final snapshot = Snapshot(
        year: 2022,
        month: 2,
        day: 15,
        hour: 10,
        minute: 30,
        second: 45,
        millisecond: 500,
      );
      final expectedMap = <String, dynamic>{
        'millisecond': 500,
        'second': 45,
        'minute': 30,
        'hour': 10,
        'day': 15,
        'month': 2,
        'year': 2022,
      };
      expect(snapshot.toMap(), equals(expectedMap));
    });

    test('should return a map with default snapshot values', () {
      final snapshot = Snapshot();
      final expectedMap = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': 1,
      };
      expect(snapshot.toMap(), equals(expectedMap));
    });
  });

  group("Snapshot fromMap() factory", () {
    test('should return a snapshot from a valid map', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': 2022,
      };
      final snapshot = Snapshot.fromMap(map);
      expect(snapshot.millisecond, 0);
      expect(snapshot.second, 0);
      expect(snapshot.minute, 0);
      expect(snapshot.hour, 0);
      expect(snapshot.day, 1);
      expect(snapshot.month, 1);
      expect(snapshot.year, 2022);
    });

    test('should throw a SnapshotError for an invalid map', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 'invalid',
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw a SnapshotError for a map with missing fields', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid millisecond', () {
      final map = <String, dynamic>{
        'millisecond': -1,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid second', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 60,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid minute', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 60,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid hour', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 24,
        'day': 1,
        'month': 1,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid day', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 32,
        'month': 1,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid month', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 13,
        'year': 2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });

    test('should throw an SnapshotError for invalid year', () {
      final map = <String, dynamic>{
        'millisecond': 0,
        'second': 0,
        'minute': 0,
        'hour': 0,
        'day': 1,
        'month': 1,
        'year': -2022,
      };
      expect(() => Snapshot.fromMap(map), throwsA(isA<SnapshotError>()));
    });
  });

  group("Snapshot toJson() method", () {
    test('should return a valid JSON string with default snapshot values', () {
      final snapshot = Snapshot();

      expect(snapshot.toJson(),
          '{"millisecond":0,"second":0,"minute":0,"hour":0,"day":1,"month":1,"year":1}');
    });

    test('should return a valid JSON string with provided snapshot values', () {
      final snapshot = Snapshot(
          year: 2022,
          month: 2,
          day: 22,
          hour: 13,
          minute: 30,
          second: 45,
          millisecond: 500);

      expect(snapshot.toJson(),
          '{"millisecond":500,"second":45,"minute":30,"hour":13,"day":22,"month":2,"year":2022}');
    });
  });

  group("Snapshot fromJson() factory", () {
    test('fromJson() should return a Snapshot object from valid JSON', () {
      const jsonStr =
          '{"millisecond": 500, "second": 59, "minute": 30, "hour": 12, "day": 15, "month": 2, "year": 2022}';
      final snapshot = Snapshot.fromJson(jsonStr);

      expect(snapshot.millisecond, 500);
      expect(snapshot.second, 59);
      expect(snapshot.minute, 30);
      expect(snapshot.hour, 12);
      expect(snapshot.day, 15);
      expect(snapshot.month, 2);
      expect(snapshot.year, 2022);
    });

    test('fromJson() should throw a SnapshotError for invalid JSON', () {
      expect(() => Snapshot.fromJson('invalid json'),
          throwsA(isA<SnapshotError>()));
    });

    test('fromJson() should throw a SnapshotError for JSON with missing fields',
        () {
      const jsonStr = '{"millisecond": 500, "second": 59, "minute": 30}';
      expect(() => Snapshot.fromJson(jsonStr), throwsA(isA<SnapshotError>()));
    });

    test('should throw a SnapshotError for an invalid JSON string', () {
      expect(() => Snapshot.fromJson('{invalid json}'),
          throwsA(isA<SnapshotError>()));
    });

    test('should throw a SnapshotError if any field is missing', () {
      expect(() => Snapshot.fromJson('{}'), throwsA(isA<SnapshotError>()));
      expect(() => Snapshot.fromJson('{"millisecond": 100}'),
          throwsA(isA<SnapshotError>()));
      expect(() => Snapshot.fromJson('{"second": 30}'),
          throwsA(isA<SnapshotError>()));
      expect(() => Snapshot.fromJson('{"minute": 15}'),
          throwsA(isA<SnapshotError>()));
      expect(() => Snapshot.fromJson('{"hour": 2}'),
          throwsA(isA<SnapshotError>()));
      expect(
          () => Snapshot.fromJson('{"day": 1}'), throwsA(isA<SnapshotError>()));
      expect(() => Snapshot.fromJson('{"month": 12}'),
          throwsA(isA<SnapshotError>()));
      expect(() => Snapshot.fromJson('{"year": 2022}'),
          throwsA(isA<SnapshotError>()));
    });
  });
}
