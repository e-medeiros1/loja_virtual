import 'package:e_shop/exceptions/auth_exceptions.dart';
import 'package:e_shop/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

enum AuthMode { LoginMode, SignupMode }

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.LoginMode;

  Map<String, String> _authData = {'email': '', 'password': ''};

  //Form key para obter as informações do formulário
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool _isLogin() => _authMode == AuthMode.LoginMode;
  bool _isSignup() => _authMode == AuthMode.SignupMode;

//TextButton para mudar pra tela de cadastro
  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.SignupMode;
      } else {
        _authMode = AuthMode.LoginMode;
      }
    });
  }

//Método para enviar as informações pro BD
  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    _showErrorDialog(String msg) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Ocorreu um erro',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            msg,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: const Text('OK'))
          ],
        ),
      );
    }

    try {
      if (_isLogin()) {
        //Login
        await auth.login(_authData['email']!, _authData['password']!);
      } else {
        //Signup
        await auth.signup(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 8,
      child: SizedBox(
        width: deviceSize.width * 1,
        height: deviceSize.height * 1,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  scale: 2,
                ),
                //E-mail formField
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      'E-mail',
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
                        email.contains('outlook.com')) {}
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
                //Confirma senha
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
                //Botão de entrar/cadastrar
                if (_isLoading)
                  const CircularProgressIndicator(
                    color: Colors.black,
                  )
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin() ? 'ENTRAR' : 'CRIAR CONTA'),
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
                //Botão que muda a tela para o signupMode
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já possui uma conta?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        _isLogin() ? 'Cadastre-se' : 'Faça o Login',
                        style: const TextStyle(
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
