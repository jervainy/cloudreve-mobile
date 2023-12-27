import 'package:flutter/material.dart';
import 'package:cloudreve_mobile/widgets/border_box.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 18,
        left: 0,
        right: 0,
        child: BorderBox(
          child: const Center(
            child: SizedBox(
              width: 300,
              child: Text(
                '使用 Cloudreve 即表示您接受我们的 服务条款 和隐私政策',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
    );
  }



}