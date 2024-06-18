enum Env {
  stage,
  prod,
  dev,
  test;

  static Env parse(final String val) => Env.values.firstWhere(
        (final env) => env.name.split('.').last == val,
        orElse: () => Env.test,
      );
}
