import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/models/social_app/comment_model.dart';
import 'package:test_new/shared/components/components.dart';

class AddComment extends StatelessWidget {
  AddComment({Key? key, required this.postId}) : super(key: key);
  final String postId;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'all comments',
              style: TextStyle(
                color:Colors.grey
              ),
            ),
            leadingWidth: 20.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: cubit.comments.isNotEmpty &&
                      state is! SocialGetCommentLoadingState,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          myDivider(),
                      itemCount: cubit.comments.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCommentItem(
                              cubit.comments[index], postId, context),
                    ),
                  ),
                  fallback: (context) => const Text(
                    'No Comments yet',
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                if (cubit.comments.isEmpty) const Spacer(),
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
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: 'type your comment here ...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.greenAccent,
                        child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              cubit.createComment(
                                dateTime: DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now())
                                    .toString(),
                                text: commentController.text,
                                postId: postId,
                              );
                              commentController.clear();
                              cubit.getComments(postId: postId);
                            },
                            child: const Icon(
                              Icons.send,
                              color: Colors.black,
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

  Widget buildCommentItem(CommentModel model, String postId, context) => Card(
        color: Colors.greenAccent[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.image),
                    radius: 20.0,
                  ),
                  SizedBox(width: 2.0,),
                  Container(
                    height: 40.0,
                    width: 1.0
                    ,color: Colors.grey,),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(model.text,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600
                      ),
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis

                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
