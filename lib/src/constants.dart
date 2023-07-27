class TimeConstants {
  static const int hoursInDay = 24;
  static const int minutesInHour = 60;
  static const int secondsInMinute = 60;
  static const int millisecondsInSecond = 1000;

  static const int millisecondsInYear = millisecondsInDay * 365;

  static const int millisecondsInLeapYear = millisecondsInDay * 366;

  static const int millisecondsInDay =
      hoursInDay * minutesInHour * secondsInMinute * millisecondsInSecond;

  static const int millisecondsInHour =
      minutesInHour * secondsInMinute * millisecondsInSecond;

  static const int millisecondsInMinute =
      secondsInMinute * millisecondsInSecond;
}
