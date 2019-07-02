import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistemita/behaviors/hiddenScrollBehavior.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  String _email;
  String _password;
  bool _isLoggingIn = false;


  _login() async {
    if (_isLoggingIn) return;
    setState(() {
      _isLoggingIn = true;
    });
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('Iniciando sesión')
    ));

    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLoggingIn = false;
      });
      return;
    }
    form.save();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/maintabs');
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
            label: 'Aceptar',
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            }),
      ));
    }finally{
      setState(() {
        _isLoggingIn=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
            behavior: HiddenScrollBehavior(),
            child: Form(
              key: _formKey,
                child: ListView(
              children: <Widget>[
                FlutterLogo(
                  style: FlutterLogoStyle.markOnly,
                  size: 200.0,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (val){
                    if(val.isEmpty){
                      return 'Por favor ingresa tu email';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      _email = val;
                    });
                  },
                ),
                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      helperText: 'No mas de  8 caracteres.',
                      suffixIcon: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child:
                        new Icon(_obscureText ? Icons.visibility
                            : Icons.visibility_off),
                      )
                  ),
                  maxLength: 8,
                  validator: (val){
                    if(val.isEmpty){
                      return 'Por favor ingresa tu contraseña';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      _password = val;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Bienvenidos a la App',
                    style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                  ),
                ),
                FlatButton(
                  child: Text('Olvidé mi contraseña'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/forgotpassword');
                  },
                  textColor: Colors.blueGrey,
                )
              ],
            ))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _login();
        },
        child: Icon(Icons.account_circle),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No tengo una cuenta'),
        )
      ],
    );
  }
}
