import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/models/social_app/post_model.dart';
import 'package:test_new/models/social_app/social_user.dart';
import 'package:test_new/modules/add_comment_screen.dart';
import 'package:test_new/modules/social_app/chat_details/chat_details_screes.dart';

Widget buildPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(model.image),
                  radius: 25.0,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name,
                          style: const TextStyle(height: 1.4),
                        ),
                        const Icon(
                          Icons.check_circle,
                          size: 14.0,
                          color: Colors.lightBlue,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      model.dateTime,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50.0,
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              model.text,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(height: 1.3),
            ),
          ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Image(
                  image: NetworkImage(model.postImage),
                  fit: BoxFit.cover,
                  height: 140.0,
                  width: double.infinity,
                ),
              ),
            ), //post image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(model.postUid);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline_rounded,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          SocialCubit.get(context).likes[index].toString(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.mode_comment_outlined,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          '0 comment',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .getComments(postId: model.postUid);
                        navigateTo(
                          context,
                          AddComment(
                            postId: model.postUid,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  SocialCubit.get(context).userModel!.image),
                              radius: 17.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5.5,
                          ),
                          Text(
                            'Write Comment ... ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_outline_rounded,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget textField({
  required TextEditingController controller,
  InputDecoration? decoration = const InputDecoration(),
  required TextInputType keyboardType,
  TextInputAction? textInputAction,
  bool obscureText = false,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldSetter<String>? onSaved,
  FormFieldValidator<String>? validator,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
}) =>
    Container(
      height: 60.0,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(),
          suffix: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffixIcon),
          ),
        ),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        validator: validator,
      ),
    );

Widget defaultTextButton({
  required VoidCallback? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// ignore: constant_identifier_names
enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  late Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget buildDefaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? action,
}) =>
    AppBar(
      title: Text(
        title!,
        style: const TextStyle(color: Colors.grey),
      ),
      leading: BackButton(),
      actions: action,
    );

Widget buildChatItem( SocialUserModel model, context ) => InkWell(
  onTap: (){
    SocialCubit.get(context).getMessages(receiverId: model.uId);
    navigateTo(context, ChatDetailsScreen( userModel: model,));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                model.image),
            radius: 25.0,
          ),
        ),
        Text(
          model.name,
          style: const TextStyle(height: 1.4),
        ),
      ],
    ),
  ),
);