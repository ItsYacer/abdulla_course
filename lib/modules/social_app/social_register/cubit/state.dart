abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String? error;

  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialLoginErrorWhenCreateChatState extends SocialRegisterStates {
  final String error;

  SocialLoginErrorWhenCreateChatState(this.error);
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialRegisterChangPasswordVisibilityState extends SocialRegisterStates {}
