enum AppEnvironment { dev, staging, prod }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.defaultCurrency,
    required this.syncIntervalSeconds,
  });

  final AppEnvironment environment;
  final String appName;
  final String defaultCurrency;
  final int syncIntervalSeconds;

  factory AppConfig.development() => const AppConfig(
        environment: AppEnvironment.dev,
        appName: 'Binly (Dev)',
        defaultCurrency: 'USD',
        syncIntervalSeconds: 30,
      );

  factory AppConfig.production() => const AppConfig(
        environment: AppEnvironment.prod,
        appName: 'Binly',
        defaultCurrency: 'USD',
        syncIntervalSeconds: 300,
      );
}
