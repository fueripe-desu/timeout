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
  });
}
