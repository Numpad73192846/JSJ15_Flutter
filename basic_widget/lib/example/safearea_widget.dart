import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {

    // 상태바, 네비게이션바 숨기기
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    // return SafeArea(
    //   // 안전 영역 사용 여부
    //   // - top, bottom, left, right
    //   top: true,
    //   bottom: true,
    //   left: true,
    //   right: true,
    //   minimum: const EdgeInsets.all(10),
    //   child: Container(
    //     height: 1000,
    //     color: Colors.blue,
    //   ),
    // );

    return Container(
      height: 1000,
      color: Colors.blue,
    );
  }
}