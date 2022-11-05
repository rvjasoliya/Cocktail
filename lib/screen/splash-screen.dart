import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/constant/hexcolor.dart';
import '../utils/constant/image.dart';
import '../utils/constant/singleTon.dart';
import 'dashboard/dashboard-screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (c, a1, a2) => const DashboardScreen(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 1000),
        )));
  }

  @override
  Widget build(BuildContext context) {
    AppSession.shared.height = MediaQuery.of(context).size.height;
    AppSession.shared.width = MediaQuery.of(context).size.width;
    return Container(
      color: thereColor,
      child: Center(
          child: Image.asset(
            AppImages.icn_logo,
            fit: BoxFit.contain,
            width: 275,
          )),
    );
  }
}
