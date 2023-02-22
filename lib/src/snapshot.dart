// A Snapshot is an immutable point on time
class Snapshot {
  late int milisecond;
  late int second;
  late int minute;
  late int hour;
  late int day;
  late int month;
  late int year;

  Snapshot({
    this.milisecond = 0,
    this.second = 0,
    this.minute = 0,
    this.hour = 0,
    this.day = 1,
    this.month = 1,
    this.year = 1,
  });

  Snapshot.now() {
    final now = DateTime.now();

    milisecond = now.millisecond;
    second = now.second;
    minute = now.minute;
    hour = now.hour;
    day = now.day;
    month = now.month;
    year = now.year;
  }

  @override
  String toString() {
    final ms = milisecond.toString().padLeft(6, '0');
    final s = second.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');
    final hr = hour.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    final m = month.toString().padLeft(2, '0');
    final y = year.toString().padLeft(4, '0');

    return "$y-$m-$d $hr:$min:$s:$ms";
  }
}
