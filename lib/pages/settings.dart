import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/register');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child:FlatButton(
          onPressed: (){
            _logout();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
      Text('Salir',style: TextStyle(color: Colors.redAccent),
      ),
      Spacer(),
      Icon(Icons.exit_to_app,
        color: Colors.redAccent,)
      ],
    ),
    )
      ),
    );
  }
}
