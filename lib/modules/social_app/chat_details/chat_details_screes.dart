import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/models/social_app/message_model.dart';
import 'package:test_new/models/social_app/social_user.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;

  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 23.0,
                  backgroundImage: NetworkImage(userModel.image),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(userModel.name),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition: SocialCubit.get(context).messages.isNotEmpty,
                    builder: (BuildContext context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var message = SocialCubit.get(context).messages[index];
                        if (SocialCubit.get(context).userModel!.uId ==
                            message.senderId) {
                          return buildMyMessage(message);
                        } else {
                          return buildMessage(message);
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5.0,
                      ),
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                    fallback: (BuildContext context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                if( SocialCubit.get(context).messages.length == 0)
                  const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: 'type your message here ...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: Colors.greenAccent,
                        child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                  receiverId: userModel.uId,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text);
                              messageController.clear();
                            },
                            child: const Icon(
                              Icons.send,
                              size: 16.0,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                bottomEnd: Radius.circular(8.0),
                topEnd: Radius.circular(5.0),
              )),
          child: Text(
            message.text,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
              color: Colors.greenAccent[100],
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                bottomStart: Radius.circular(8.0),
                topEnd: Radius.circular(5.0),
              )),
          child: Text(
            message.text,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
        ),
      );
}
