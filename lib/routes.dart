import 'package:flutter/material.dart';
import 'package:sistemita/pages/forgotpassword.dart';
import 'package:sistemita/pages/login.dart';
import 'package:sistemita/pages/mainTabs.dart';
import 'package:sistemita/pages/register.dart';

Map<String ,WidgetBuilder> buildAppRoutes(){
  return {
    '/login': (BuildContext context) =>  LoginPage(),
    '/register': (BuildContext context) =>  RegisterPage(),
    '/forgotpassword': (BuildContext context) =>  ForgotPasswordPage(),
    '/maintabs': (BuildContext context) =>  MainTabsPage(),
  };
}