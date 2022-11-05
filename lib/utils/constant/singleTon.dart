
class AppSession {
  // singleton
  static final AppSession _singleton = AppSession._internal();
  factory AppSession() => _singleton;
  AppSession._internal();
  static AppSession get shared => _singleton;
  double? width;
  double? height;
// double height = MediaQuery.of(context).size.height;
}