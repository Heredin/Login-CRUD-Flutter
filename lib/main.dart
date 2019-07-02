import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistemita/pages/mainTabs.dart';
import 'package:sistemita/pages/register.dart';
import 'package:sistemita/routes.dart';
import 'package:sistemita/theme.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Widget _rootPage = RegisterPage();

  Future<Widget> getRootPage()async=>
      await FirebaseAuth.instance.currentUser()==null
      ?RegisterPage()
       : MainTabsPage();

  @override
   initState() {
    super.initState();
    getRootPage().then((Widget page){
      setState(() {
       _rootPage=page;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: _rootPage,
      routes: buildAppRoutes(),
   //   theme: buildAppTheme(),
    );
  }
}
