// A Snapshot is an immutable point on time
class Snapshot {
  int milisecond;
  int second;
  int minute;
  int hour;
  int day;
  int month;
  int year;

  Snapshot({
    this.milisecond = 0,
    this.second = 0,
    this.minute = 0,
    this.hour = 0,
    this.day = 1,
    this.month = 1,
    this.year = 1,
  });
}
