import 'package:firebase_auth_flow/views/signup_page.dart';
import 'package:firebase_auth_flow/providers/auth_provider.dart';
import 'package:firebase_auth_flow/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  static const String routeName = 'signin-page';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _fKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String _email, _password;

  void _submit() async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    if (!_fKey.currentState.validate()) return;

    _fKey.currentState.save();

    print('e-mail: $_email, şifre: $_password');

    try {
      await context
          .read<AuthProvider>()
          .signIn(email: _email, password: _password);
    } catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthProvider>().state;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Notlarım',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Form(
                key: _fKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String val) {
                          if (!val.trim().contains('@')) {
                            return 'Geçersiz e-mail';
                          }
                          return null;
                        },
                        onSaved: (val) => _email = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: 'Şifre',
                          prefixIcon: Icon(Icons.security),
                        ),
                        validator: (String val) {
                          if (val.trim().length < 6) {
                            return 'Şifreniz en az 6 karakter olmalıdır';
                          }
                          return null;
                        },
                        onSaved: (val) => _password = val,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: authState.loading == true ? null : _submit,
                      child: Text(
                        'Oturum Aç',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      onPressed: authState.loading == true
                          ? null
                          : () {
                              Navigator.pushNamed(
                                context,
                                SignupPage.routeName,
                              );
                            },
                      child: Text(
                        'Kayıt Ol!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
