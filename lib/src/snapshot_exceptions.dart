class SnapshotDateError extends ArgumentError {
  final String errMessage;

  SnapshotDateError(this.errMessage) : super(errMessage);

  @override
  String toString() {
    return "$runtimeType: $message";
  }
}
