import 'package:flutter/material.dart';

class LoginProvidersModel {
  String? providerName;
  IconData? providerIcon;
  void Function()? onTap;

  LoginProvidersModel({
    this.providerName,
    this.providerIcon,
    this.onTap,
  });
}
