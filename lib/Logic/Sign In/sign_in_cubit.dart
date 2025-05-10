import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../Repository/firebase_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final FirebaseRepository _firebaseRepository;
  SignInCubit({required FirebaseRepository myFirebaseRepository})
    : _firebaseRepository = myFirebaseRepository,
      super(const SignInState());

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(status: SignInStatus.processing));
    try {
      await _firebaseRepository.signIn(email, password);
      emit(state.copyWith(status: SignInStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: SignInStatus.failed,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseRepository.logOut();
    } catch (error) {
      debugPrint("Error logging out: $error");
    }
  }
}
