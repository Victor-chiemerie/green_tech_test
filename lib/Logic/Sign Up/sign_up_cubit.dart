import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Model/user.dart';
import '../../Repository/firebase_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseRepository _firebaseRepository;
  SignUpCubit({required FirebaseRepository myFirebaseRepository})
    : _firebaseRepository = myFirebaseRepository,
      super(SignUpState(user: myUser.empty, password: ""));

  Future<void> signUp(myUser user, String password) async {
    emit(state.copyWith(status: SignUpStatus.processing));
    try {
      await _firebaseRepository.signUp(user, password);
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.failed,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
