class AuthException implements Exception {
  static const Map<String, String> errors = {
    //Cadastro
    'EMAIL_EXISTS': 'O e-mail utilizado já existe',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente, tente novamente mais tarde',

    //Login
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_PASSWORD': 'Senha inválida',
    'USER_DISABLED': 'Usuário desabilitado',
  };

  final String key;

  AuthException({required this.key});

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
