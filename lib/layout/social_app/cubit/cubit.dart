import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/models/social_app/comment_model.dart';
import 'package:test_new/models/social_app/message_model.dart';
import 'package:test_new/models/social_app/post_model.dart';
import 'package:test_new/models/social_app/social_user.dart';
import 'package:test_new/modules/social_app/chats/chats_screen.dart';
import 'package:test_new/modules/social_app/feeds/feed_screen.dart';
import 'package:test_new/modules/social_app/settings/setting_screen.dart';
import 'package:test_new/modules/social_app/users/users_screen.dart';
import 'package:test_new/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData() {
    // emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print('inside fire base method');
      print(uId);
      userModel = SocialUserModel.formJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = const [
    FeedsScreen(),
    ChatsScreen(),
    FeedsScreen(),
    UserScreen(),
    SettingScreen()
  ];

  List<String> titles = ['Home', 'Chat', 'Home', 'Profile', 'Settings'];

  void changeBottomNav(index) {
    currentIndex = index;
    if (index == 0) {
      getPosts();
    }
    if (index == 1) {
      getAllUser();
    }
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      emit(SocialChangeBottomNavState());
    }
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Feeds',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle),
      label: 'post',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_applications), label: 'settings')
  ];

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      //print(profileImage!.path.toString());
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
      //print('no image selected');
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
      //print('no image selected');
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialLoadingUserState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        updateUser(name: name, phone: phone, bio: bio, profile: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialLoadingUserState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print(error.toString());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profile,
    String? cover,
  }) {
    emit(SocialGetUserLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      image: profile ?? userModel!.image,
      bio: bio,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(SocialUpdateUserSuccessState());
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());
      //print('no image selected');
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(value.id)
          .update({'postUid': value.id});
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<int> likes = [];
  List<PostModel> posts = [];

  void getPosts() {
    emit(SocialGetPostSuccessState());
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          posts.add(PostModel.formJson(element.data()));
          likes.add(value.docs.length);
         posts =posts.toSet().toList();
          emit(SocialGetPostSuccessState());

        }).catchError((error) {});
      }
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    emit(SocialLikeLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUser() {
    users = [];
    if (users.isEmpty) {
      emit(SocialGetAllUserLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.formJson(element.data()));
          }
        }
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    //for sender
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    //for receiver
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      //لعدم التكرار بيصفر كل مره و يبدا من جديد
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.formJson(element.data()));
      }
      emit(SocialGetMessagesSuccessState());
    });
  }

  CommentModel? commentModel;

  void createComment({
    required String dateTime,
    required String text,
    required String postId,
  }) {
    emit(SocialCreatePostLoadingState());
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set(commentModel.toMap())
        .then((value) {
      print('comment done');
      emit(CommentAddedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CommentAddedErrorState(error.toString()));
    });
  }

  List<CommentModel> comments = [];

  void getComments({required String postId}) {
    emit(SocialGetCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      comments = [];
      for (var element in value.docs) {
        print('comment added');
        comments.add(CommentModel.formJson(element.data()));
        emit(SocialGetCommentSuccessState());
      }
    }).catchError((error) {
      emit(SocialGetCommentErrorState(error.toString()));
    });
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchList = [];
  String? search;

  void searchItem(String name) {
    searchList = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element['name'].toString().startsWith(name)) {
          print(element['name'].toString());
          searchList.add(element);
        }
        searchList =searchList.toSet().toList();
        emit(SocialGetSearchSuccessState());
      });
    }).catchError((error) {});
  }
}
