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
}
