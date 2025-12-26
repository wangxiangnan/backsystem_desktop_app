import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'environment.dart';

class AppConfig {
  final String apiBaseUrl;
  final bool enableLogging;
  final Environment env;

  AppConfig({
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.env,
  });

  // 根据环境加载配置
  static Future<AppConfig> load() async {
    const appEnv = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    late Environment environment;

    switch (appEnv) {
      case 'dev':
        environment = Environment.dev;
      case 'test':
        environment = Environment.test;
      case 'staging':
        environment = Environment.staging;
      case 'prod':
        environment = Environment.prod;
      default:
        environment = Environment.dev;
    }
    await dotenv.load(fileName: '.env.$appEnv');
    return AppConfig(
      apiBaseUrl: dotenv.get('API_BASE_URL'),
      enableLogging: environment == Environment.dev,
      env: environment
    );
  }

  bool get isDev => env == Environment.dev;
  bool get isTest => env == Environment.test;
  bool get isStaging => env == Environment.staging;
  bool get isProd => env == Environment.prod;
}