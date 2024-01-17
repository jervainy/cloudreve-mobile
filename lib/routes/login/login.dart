import 'package:bot_toast/bot_toast.dart';
import 'package:cloudreve_mobile/common/global.dart';
import 'package:cloudreve_mobile/routes/login/login_box.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Global.readToken() != null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      });
    }
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              children: [
                wrapBox(context),
                copyright()
              ],
            )));
  }

  Widget copyright() {
    return const Positioned(
      bottom: 18,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Text(
            '使用 Cloudreve 即表示您接受我们的 服务条款 和隐私政策',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget wrapBox(BuildContext context) {
    return const Positioned(
        bottom: 150,
        top: 20,
        left: 0,
        right: 0,
        child: LoginBox(),
    );
  }
}

