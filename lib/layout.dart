
import 'package:bot_toast/bot_toast.dart';
import 'package:cloudreve_mobile/constants/const.dart';
import 'package:cloudreve_mobile/pages/initialization/initialization.dart';
import 'package:cloudreve_mobile/pages/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<Layout> {
  String? serverJson;

  @override
  void initState() {
    super.initState();
    initServerJson();
  }

  void initServerJson() async {
    var cancel = BotToast.showLoading();
    final prefs = await SharedPreferences.getInstance();
    cancel();
    var json = prefs.getString(const_server);
    setState(() {
      serverJson = json;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (serverJson == null) return const InitializationPage();
    return const LoginPage();
  }

}
