class LoginPath {
  static final _instance = LoginPath._();

  LoginPath._();

  factory LoginPath() => _instance;

  final String presentation = "/presentation";
  final String login = "/login";
}