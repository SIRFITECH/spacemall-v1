class LoginFailure {
  final String message;
  const LoginFailure([this.message = 'An error occured']);

  factory LoginFailure.code(String code) {
    switch (code) {
      // case:
      default:
        return const LoginFailure('');
    }
  }
}
