abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialVerifySuccessState extends SocialStates {}

class SocialVerifyErrorState extends SocialStates {
  final String error;

  SocialVerifyErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialAddPostState extends SocialStates {}
class SocialLikeLoadingState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialUpdateUserSuccessState extends SocialStates {}

class SocialLoadingUserState extends SocialStates {}

//Create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//get posts

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

//post like

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

//get all users

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

//chats
class SocialNewChatsAddSuccessState extends SocialStates {}
class SocialNewChatsAddErrorState extends SocialStates {
  final String error;

  SocialNewChatsAddErrorState(this.error);
}
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}
//comment

class CommentAddedSuccessState extends SocialStates {}

class CommentAddedErrorState extends SocialStates {
  final String error;

  CommentAddedErrorState(this.error);
}

class SocialGetCommentLoadingState extends SocialStates {}

class SocialGetCommentSuccessState extends SocialStates {}

class SocialGetCommentErrorState extends SocialStates {
  final String error;

  SocialGetCommentErrorState(this.error);
}


class SocialGetSearchSuccessState extends SocialStates {}
