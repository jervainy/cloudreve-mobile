import 'package:cloudreve_mobile/routes/dashboard/dashboard.dart';
import 'package:cloudreve_mobile/routes/login/login.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => const LoginPage(),
  '/dashboard': (context) => const DashboardPage(),
};