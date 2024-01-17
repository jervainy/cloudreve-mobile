import 'package:bot_toast/bot_toast.dart';
import 'package:cloudreve_mobile/common/global.dart';
import 'package:cloudreve_mobile/routes/login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart';

void main() {
  Global.init().then((e) => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalStore())
      ],
      child: const MyApp()
  )));
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
      home: const LoginPage(),
    );
  }

}


class GlobalStore with ChangeNotifier, DiagnosticableTreeMixin {

  bool _showBottomBar = true;

  bool get showBottomBar => _showBottomBar;

  void setBottomBarValue(bool val) {
    _showBottomBar = val;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('_showBottomBar', _showBottomBar ? 1 : 0));
  }
}

