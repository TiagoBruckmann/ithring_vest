final class EnvSettings {

  // HTTP CONFIGURATIONS
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: "WITHOUT_BASE_URL");
  static const String clientName = String.fromEnvironment('CLIENT_NAME', defaultValue: "WITHOUT_CLIENT_NAME");
  static const String xApiKey = String.fromEnvironment('X_API_KEY', defaultValue: "WITHOUT_X_API_KEY");

  // ONESIGNAL CONFIGURATIONS
  static const String onesignalAppId = String.fromEnvironment('ONESIGNAL_APP_ID', defaultValue: "WITHOUT_ONESIGNAL_APP_ID");

  // CURRENCIES CONFIGURATION
  static const String awesomeBaseUrl = String.fromEnvironment('AWESEOMEAPI_API_URL', defaultValue: "WITHOUT_AWESEOMEAPI_API_URL");
  static const String awesomeApiKey = String.fromEnvironment('AWESEOMEAPI_API_KEY', defaultValue: "WITHOUT_AWESEOMEAPI_API_KEY");

}