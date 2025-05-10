import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../Model/user.dart';
import '../../Repository/firebase_repository.dart';

part 'my_user_state.dart';

class MyUserCubit extends Cubit<MyUserState> {
  final FirebaseRepository _firebaseRepository;
  MyUserCubit({required FirebaseRepository myFirebaseRepository})
    : _firebaseRepository = myFirebaseRepository,
      super(MyUserState(user: myUser.empty));

  Future<void> getUser(String email) async {
    emit(state.copyWith(status: MyUserStatus.processing));
    try {
      // Validate email
      if (email.isEmpty) {
        throw Exception('Email cannot be empty');
      }

      myUser? user = await _firebaseRepository.getUser(email);

      if (user != null) {
        emit(state.copyWith(user: user, status: MyUserStatus.success));
        return;
      } else {
        emit(state.copyWith(status: MyUserStatus.failed));
        debugPrint('Inable to get user');
        return;
      }
    } catch (error) {
      emit(state.copyWith(status: MyUserStatus.failed));
      debugPrint('Error getting user: $error');
    }
  }
}
