final class EnvSettings {

  static const env = String.fromEnvironment("ENV", defaultValue: "WITHOUT_ENV");

  /// HTTP CONFIGURATIONS
  static const baseUrl = String.fromEnvironment("BASE_URL", defaultValue: "WITHOUT_BASE_URL");
  static const clientName = String.fromEnvironment("CLIENT_NAME", defaultValue: "WITHOUT_CLIENT_NAME");
  static const xApiKey = String.fromEnvironment("X_API_KEY", defaultValue: "WITHOUT_X_API_KEY");

  /// ONESIGNAL
  static const onesignalAppId = String.fromEnvironment("ONESIGNAL_APP_ID", defaultValue: "WITHOUT_ONESIGNAL_APP_ID");

  /// AWESOME API
  static const awesome = String.fromEnvironment("AWESOME_API_URL", defaultValue: "WITHOUT_AWESOME_API_URL");
  static const basicAuthToken = String.fromEnvironment("AWESOME_API_KEY", defaultValue: "WITHOUT_AWESOME_API_KEY");

}