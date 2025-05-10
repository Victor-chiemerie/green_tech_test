part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, processing, success, failed }

class SignUpState extends Equatable {
  final myUser user;
  final String password;
  final SignUpStatus status;
  final String? errorMessage;

  const SignUpState({
    required this.user,
    required this.password,
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  SignUpState copyWith({
    myUser? user,
    String? password,
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      user: user ?? this.user,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, password, status, errorMessage];
}
