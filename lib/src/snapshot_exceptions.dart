class InvalidDate {
  final int day;
  final int month;
  final int year;

  final String invalidParameter;

  InvalidDate(this.day, this.month, this.year, this.invalidParameter);

  @override
  String toString() {
    return "Invalid date: $day/${month.toString().padLeft(2, '0')}/$year";
  }
}

class InvalidTime {
  final int millisecond;
  final int second;
  final int minute;
  final int hour;

  final String invalidParameter;

  InvalidTime(this.millisecond, this.second, this.minute, this.hour,
      this.invalidParameter);

  @override
  String toString() {
    final ms = millisecond.toString().padLeft(3, '0');
    final s = second.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');
    final hr = hour.toString().padLeft(2, '0');

    return "Invalid time: $hr:$min:$s.$ms";
  }
}

class DateTimeError extends ArgumentError {
  late final String errMsg;
  late final String errBody;
  late final String? hint;
  final String invalidDateMsg;
  final String invalidParameter;

  DateTimeError(
    String errorMessage,
    this.invalidDateMsg,
    this.invalidParameter, {
    String? hint,
  }) : super(errorMessage) {
    // errMsg = runtimeType + errBody
    errMsg = "$runtimeType: $message";

    // Error body is the 'errMsg' without the runtimeType
    errBody = errMsg.split(":").last.trim();

    // Hint is the message passed by who thrown the exception, and gives a hint
    // on how to solve the problem
    this.hint = hint == null ? "" : "\n$hint";
  }

  @override
  String toString() {
    // Checks if error happened in copyWith or Snapshot constructor
    final isCopyWithErr = stackTrace.toString().contains("copyWith");
    final functionName = isCopyWithErr ? ".copyWith" : "";

    // Invalid code is the piece of code that raised the error
    final invalidCode =
        "Snapshot$functionName($invalidParameter: YOU SHOULD CORRECT HERE)";

    return "$errMsg\n$invalidDateMsg\n$hint${hint!.isNotEmpty ? ' -> $invalidCode\n\n' : ''}$stackTrace";
  }
}

class SnapshotDateError extends DateTimeError {
  final InvalidDate invalidDate;

  SnapshotDateError(String errorMessage, this.invalidDate, {String? hint})
      : super(
          errorMessage,
          invalidDate.toString(),
          invalidDate.invalidParameter,
          hint: hint,
        );
}

class SnapshotTimeError extends DateTimeError {
  InvalidTime invalidTime;

  SnapshotTimeError(String errorMessage, this.invalidTime, {String? hint})
      : super(
          errorMessage,
          invalidTime.toString(),
          invalidTime.invalidParameter,
          hint: hint,
        );
}

class SnapshotError implements Exception {
  final String errMessage;

  SnapshotError(this.errMessage);

  @override
  String toString() {
    return "$runtimeType: $errMessage";
  }
}
