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

class SnapshotDateError extends ArgumentError {
  final InvalidDate invalidDate;

  late final String errMsg;
  late final String errBody;
  late final String invalidDateMsg;
  late final String? hint;
  late final String invalidCode;

  SnapshotDateError(String errorMessage, this.invalidDate, {String? hint})
      : super(errorMessage) {
    // errMsg = runtimeType + errBody
    errMsg = "$runtimeType: $message";

    // Error body is the 'errMsg' without the runtimeType
    errBody = errMsg.split(":").last.trim();

    // InvalidDateMsg is the toString representation of InvalidDate
    invalidDateMsg = invalidDate.toString();

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
    invalidCode =
        "Snapshot$functionName(${invalidDate.invalidParameter}: YOU SHOULD CORRECT HERE)";

    return "$errMsg\n$invalidDateMsg\n$hint${hint!.isNotEmpty ? ' -> $invalidCode\n\n' : ''}$stackTrace";
  }
}

class SnapshotTimeError extends ArgumentError {
  final String errMessage;

  SnapshotTimeError(this.errMessage) : super(errMessage);

  @override
  String toString() {
    return "$runtimeType: $message";
  }
}

class SnapshotMissingField extends FormatException {
  final String errMessage;

  SnapshotMissingField(this.errMessage) : super(errMessage);

  @override
  String toString() {
    return "$runtimeType: $message";
  }
}

class SnapshotError implements Exception {
  final String errMessage;

  SnapshotError(this.errMessage);

  @override
  String toString() {
    return "$runtimeType: $errMessage";
  }
}
