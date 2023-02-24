class SnapshotDateError extends ArgumentError {
  final String errMessage;

  SnapshotDateError(this.errMessage) : super(errMessage);

  @override
  String toString() {
    return "$runtimeType: $message";
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
