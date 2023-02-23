import 'package:flutter_test/flutter_test.dart';

import 'package:timeout/timeout.dart';

void main() {
  group('Snapshot', () {
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

    test('should create a snapshot with the provided date and time', () {
      const snapshot = Snapshot(
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
      const snapshot = Snapshot();
      expect(snapshot.millisecond, equals(0));
      expect(snapshot.second, equals(0));
      expect(snapshot.minute, equals(0));
      expect(snapshot.hour, equals(0));
      expect(snapshot.day, equals(1));
      expect(snapshot.month, equals(1));
      expect(snapshot.year, equals(1));
    });

    test('should return a new Snapshot object with the updated fields', () {
      // Arrange
      const snapshot = Snapshot(
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
      const snapshot = Snapshot(
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
      const snapshot = Snapshot(
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

    test(
        'should throw an exception when creating snapshot with invalid date/time values',
        () {
      expect(() => const Snapshot(year: 0), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(year: -2022), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(month: 0), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(month: 13), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(day: 0), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(day: 32), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(hour: -1), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(hour: 24), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(minute: -1), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(minute: 60), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(second: -1), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(second: 60), throwsA(isA<ArgumentError>()));
      expect(
          () => const Snapshot(millisecond: -1), throwsA(isA<ArgumentError>()));
      expect(() => const Snapshot(millisecond: 1000),
          throwsA(isA<ArgumentError>()));
    });
  });
}
