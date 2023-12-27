import 'package:cloudreve_mobile/pages/initialization/copyright_widget.dart';
import 'package:cloudreve_mobile/widgets/border_box.dart';
import 'package:flutter/material.dart';

class InitializationPage extends StatelessWidget {
  const InitializationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              children: [wrapBox(context), const CopyrightWidget()],
            )));
  }

  Widget wrapBox(BuildContext context) {
    final querySize = MediaQuery.of(context).size;
    return Positioned(
        bottom: 40,
        top: 0,
        left: 0,
        right: 0,
        child: Center(
          child: SizedBox(
              width: querySize.width * 0.8,
              height: 400,
              child: BorderBox(
                  child: Column(
                children: [
                  const Text("1111"),
                  const Text('站点绑定',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Container(
                      margin: const EdgeInsets.only(top: 200),
                      child: BorderBox(
                          child: Column(
                        children: [
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: BorderBox(
                                child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('继续'),
                            )),
                          ),
                          const Text(
                              '请输入访问 web 端的站点地址，请确保站点协议(http/https)和 web 站点相同',
                              textAlign: TextAlign.center)
                        ],
                      )))
                ],
              ))),
        ));
  }
}
