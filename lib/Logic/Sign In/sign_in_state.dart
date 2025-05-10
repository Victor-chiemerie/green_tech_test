part of 'sign_in_cubit.dart';

enum SignInStatus { initial, processing, success, failed }

class SignInState extends Equatable {
  final String email;
  final String password;
  final SignInStatus status;
  final String? errorMessage;

  const SignInState({
    this.email = '',
    this.password = '',
    this.status = SignInStatus.initial,
    this.errorMessage,
  });

  SignInState copyWith({
    String? email,
    String? password,
    SignInStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}
