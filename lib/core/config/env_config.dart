class EnvConfig {
  EnvConfig._();

  static const String environment =
      String.fromEnvironment(
    'ENV_NAME',
    defaultValue: 'DEVELOPMENT',
  );

  static const String baseUrl =
      String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://fakestoreapi.com',
  );

  static const bool showDebugBanner =
      bool.fromEnvironment(
    'SHOW_DEBUG_BANNER',
    defaultValue: true,
  );

  static bool get isProduction =>
      environment == 'PRODUCTION';
}