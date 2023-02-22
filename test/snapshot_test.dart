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
  });
}
