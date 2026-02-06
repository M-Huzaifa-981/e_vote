import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';


class SplashProvider extends ChangeNotifier {
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
