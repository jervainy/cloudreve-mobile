import 'package:bot_toast/bot_toast.dart';
import 'package:cloudreve_mobile/layout.dart';
import 'package:cloudreve_mobile/pages/initialization/initialization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: BotToastInit(),
      routes: routes,
      initialRoute: '/initialization',
      home: const Layout(),
    );
  }
}
