import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/settings_provider.dart';
import 'package:todo_app/core/services/firebase_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      FirebaseService().checkLoginStatus();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: Image.asset(
        vm.isDark()
            ? 'assets/images/splash_dark.png'
            : 'assets/images/splash_light.png',
        fit: BoxFit.cover,
        height: mediaQuery.height,
        width: mediaQuery.width,
      ),
    );
  }
}
