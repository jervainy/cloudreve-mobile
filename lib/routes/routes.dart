import 'package:cloudreve_mobile/pages/initialization/initialization.dart';
import 'package:cloudreve_mobile/pages/login/login.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  '/initialization': (context) => const InitializationPage(),
  '/login': (context) => const LoginPage(),
};