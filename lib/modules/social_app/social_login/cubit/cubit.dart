import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/modules/social_app/social_login/cubit/state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void loginUsers({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      debugPrint(value.user!.email);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangPasswordVisibilityState());
  }
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
