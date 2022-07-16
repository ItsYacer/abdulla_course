import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/models/social_app/social_user.dart';
import 'package:test_new/modules/social_app/social_register/cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void registerUsers({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? uId,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      createUsers(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      debugPrint(value.user!.email);
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialRegisterErrorState(error));
    });
  }

  late SocialUserModel registerModel;

  void createUsers({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    registerModel = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg',
      bio: 'Write your bio here ...',
      cover: 'https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?w=1060&t=st=1656400846~exp=1656401446~hmac=9789c1bdc08f3f2ad63016cf80d459803d2128a91b2527f875ac1d42ecc20eb7',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(registerModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialRegisterChangPasswordVisibilityState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
