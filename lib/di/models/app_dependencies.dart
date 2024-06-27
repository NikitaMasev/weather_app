final class AppDependencies {
  AppDependencies({required this.data});

  final int data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDependencies &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}
