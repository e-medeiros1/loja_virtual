import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

enum AuthMode { LoginMode, SignupMode }

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final AuthMode _authMode = AuthMode.LoginMode;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.LoginMode;
  bool _isSignup() => _authMode == AuthMode.SignupMode;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode == AuthMode.SignupMode;
      } else {
        _authMode == AuthMode.LoginMode;
      }
    });
  }

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 8,
      // color: Colors.white,
      child: SizedBox(
        width: deviceSize.width * 1,
        height: 900,
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  scale: 2,
                  // color: Colors.white,
                ),
                //E-mail formField
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      'E-mail',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty ||
                        email.contains('@') ||
                        email.contains('gmail.com') ||
                        email.contains('hotmail.com') ||
                        email.contains('outlook.com')) ;
                  },
                ),
                //Password formField
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length < 5) {
                      return 'Informe uma senha válida';
                    }
                    return null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Confirmar senha'),
                    ),
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (_password) {
                            final password = _password ?? '';
                            if (password != _passwordController.text) {
                              return 'As senhas não conferem';
                            }
                            return null;
                          },
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin() ? 'ENTRAR' : 'CADASTRAR'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      )),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLogin())
                      Text(
                        _isSignup() ? '' : 'Já possui uma conta? ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                      ),
                    if (_isLogin())
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: const Text(
                          'Cadastre-se',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
