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
