class SignupEmailFailure {
  final String message;
  const SignupEmailFailure([this.message = "Ocurrio un error"]);
  factory SignupEmailFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const SignupEmailFailure('Usuario no registrado');
      case 'wrong-password':
        return const SignupEmailFailure('Contraseña incorrecta');
      case 'weak-password':
        return const SignupEmailFailure(
            'La contraseña debe contener al menos 6 caracteres');
      case 'invalid-email':
        return const SignupEmailFailure('Correo electrónico invalido');
      case 'email-already-in-use':
        return const SignupEmailFailure(
            'Este correo ya esta asociado a una cuenta');
      case 'operation-not-allowed':
        return const SignupEmailFailure('Operación no permitida');
      case 'user-disabled':
        return const SignupEmailFailure('');
      case 'network-request-failed':
        return const SignupEmailFailure('Verifica tu conexión a internet');
      default:
        print(code);
        return const SignupEmailFailure();
    }
  }
}
