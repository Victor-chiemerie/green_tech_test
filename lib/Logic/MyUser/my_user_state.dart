part of 'my_user_cubit.dart';

enum MyUserStatus { processing, success, failed }

class MyUserState extends Equatable {
  final myUser user;
  final MyUserStatus status;

  const MyUserState({
    required this.user,
    this.status = MyUserStatus.processing,
  });

  MyUserState copyWith({
    myUser? user,
    MyUserStatus? status,
  }) {
    return MyUserState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [user, status];
}
