import 'package:cloudreve_mobile/api/webdav.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cloudreve_mobile/widgets/logo/logo.dart';
import 'package:cloudreve_mobile/common/iconfont.dart';
import 'package:cloudreve_mobile/common/global.dart';
import 'package:cloudreve_mobile/common/http.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<StatefulWidget> createState() => _LoginBoxState();

}

class _LoginBoxState extends State<LoginBox> {
  bool hasServer = Global.readServerAddress() != null;
  final GlobalKey<_LoginInputState> _serverState = GlobalKey();
  final GlobalKey<_LoginInputState> _usernameState = GlobalKey();
  final GlobalKey<_LoginInputState> _passwordState = GlobalKey();

  @override
  void initState() {
    if (mounted) {
      Future.delayed(Duration(seconds: 1), () {
        var serverController = _serverState.currentState!._controller;
        serverController.text = 'http://172.23.195.188:5212/';
        Global.saveServerAddress(serverController.text);
        setState(() {
          hasServer = true;
        });

        Future.delayed(Duration(seconds: 1), () {
          var usernameController = _usernameState.currentState!._controller;
          var passwordController = _passwordState.currentState!._controller;
          usernameController.text = 'admin@cloudreve.org';
          passwordController.text = '8hFFSqSd';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final qSize = MediaQuery.of(context).size;
    final w = qSize.width * 0.8;
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(size: 120),
            title(),
            form(),
          ],
        )
    );
  }

  Widget title() {
    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: hasServer ? const Text('用户登录', style: style) :  const Text('站点绑定', style: style)
    );
  }

  Widget form() {
    return Container(
        margin: const EdgeInsets.only(top: 80),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              ...inputForm(),
              button(),
              tip()
            ],
          ),
        ));
  }

  List<Widget> inputForm() {
    if (hasServer) {
      return [
        _LoginInput('用户名', const Icon(IconFont.iconUser), key: _usernameState),
        _LoginInput('密码', const Icon(IconFont.iconLockOn), key: _passwordState, obscureText: true),
      ];
    }
    return [
      _LoginInput('http(s)://站点地址', const Icon(IconFont.iconInternet), key: _serverState),
    ];
  }

  Widget button() {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromRGBO(41, 94, 241, 0.7);
            }
            return const Color.fromRGBO(41, 94, 241, 1.0);
          }),
          foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        ),
        child: hasServer ? const Text('登录') : const Text('继续'),
        onPressed: () async {
          if (hasServer) {
            var usernameText = _usernameState.currentState?.getValueText();
            if (usernameText == null || usernameText == '') {
              _usernameState.currentState?.setErrorText('请输入用户名');
              return;
            }
            var passwordText = _passwordState.currentState?.getValueText();
            if (passwordText == null || passwordText == '') {
              _passwordState.currentState?.setErrorText('请输入密码');
              return;
            }
            var response = await WebDavApi.login(usernameText, passwordText);
            Global.setTokenData(response);
            Navigator.pushNamed(context, '/dashboard');
          } else {
            var text = _serverState.currentState?.getValueText();
            if (text == null || text == '') {
              _serverState.currentState?.setErrorText('请输入站点地址');
            } else {
              try {
                await HttpDio.dio.get(text);
                Global.saveServerAddress(text);
                setState(() {
                  hasServer = true;
                });
              } on DioException catch (e) {
                _serverState.currentState?.setErrorText('网络连接失败，请检查网络或者确定站点地址是否正确');
              }
            }
          }
        },
      ),
    );
  }

  Widget tip() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
      child: hasServer ? const Text('请输入正确的用户名、密码进行登陆',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ) : const Text('请输入访问 web 端的站点地址，请确保站点协议(http/https)和 web 站点相同',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

}





class _LoginInput extends StatefulWidget {
  final String hintText;
  final Widget icon;
  final bool obscureText;
  const _LoginInput(this.hintText, this.icon, {this.obscureText = false, super.key});
  @override
  State<StatefulWidget> createState() => _LoginInputState();
}

class _LoginInputState extends State<_LoginInput> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool _obscureView = false;

  @override
  Widget build(BuildContext context) {
    const double h = 80;
    return Container(
        constraints: const BoxConstraints(minHeight: h, maxHeight: h),
        child: TextField(
          controller: _controller,
          autofocus: true,
          obscureText: widget.obscureText && !_obscureView,
          style: const TextStyle(
              backgroundColor: Color.fromRGBO(239, 239, 243, 0.8)
          ),
          decoration: InputDecoration(
            fillColor: const Color.fromRGBO(239, 239, 243, 1),
            filled: true,
            border: InputBorder.none,
            prefixIcon: widget.icon,
            suffixIcon: !widget.obscureText ? null : IconButton(icon: Icon(_obscureView ? IconFont.iconViewOff : IconFont.iconViewOn), onPressed: () {
              setState(() {
                _obscureView = !_obscureView;
              });
            }),
            hintText: widget.hintText,
            errorText: _errorText,
          ),
          onChanged: (v) {
            setState(() {
              _errorText = null;
            });
          },
        )
    );
  }

  String getValueText() => _controller.text;

  void setErrorText(String text) {
    setState(() {
      _errorText = text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}