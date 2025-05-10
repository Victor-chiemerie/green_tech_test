import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Repository/firebase_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseRepository firebaseRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthCubit({required FirebaseRepository myFirebaseRepository})
    : firebaseRepository = myFirebaseRepository,
      super(const AuthState()) {
    _userSubscription = firebaseRepository.user.listen((authUser) {
      if (authUser != null) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: authUser));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
