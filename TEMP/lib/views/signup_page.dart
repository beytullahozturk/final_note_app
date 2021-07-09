import 'package:firebase_auth_flow/providers/auth_provider.dart';
import 'package:firebase_auth_flow/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = 'signup-page';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _fKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _passwordController = TextEditingController();
  String _name, _email, _password;

  void _submit() async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    if (!_fKey.currentState.validate()) return;

    _fKey.currentState.save();

    print('ad: $_name, e-mail: $_email, şifre: $_password');

    try {
      await context
          .read<AuthProvider>()
          .signUp(context, name: _name, email: _email, password: _password);
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
                          labelText: 'Ad',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (String val) {
                          if (val.trim().isEmpty) {
                            return 'Ad zorunlu';
                          }
                          return null;
                        },
                        onSaved: (val) => _name = val,
                      ),
                    ),
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
                        controller: _passwordController,
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
                          labelText: 'Şifreyi Onayla',
                          prefixIcon: Icon(Icons.security),
                        ),
                        validator: (String val) {
                          if (_passwordController.text != val) {
                            return 'Şifreler eşleşmiyor';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: authState.loading == true ? null : _submit,
                      child: Text(
                        'Kayıt Ol',
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
                              Navigator.pop(context);
                            },
                      child: Text(
                        'Oturum Aç!',
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
