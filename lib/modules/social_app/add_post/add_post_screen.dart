import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/shared/components/components.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var postController =TextEditingController();
        return Scaffold(
          appBar:
          buildDefaultAppBar(context: context, title: 'Create Post', action: [
            MaterialButton(
              onPressed: () {
                var now =DateTime.now();
                if(SocialCubit.get(context).postImage ==null){
                  SocialCubit.get(context).createPost(dateTime: now.toLocal().toString(), text: postController.text);
                  SocialCubit.get(context).getPosts();
                  Navigator.pop(context);
                }else{
                  SocialCubit.get(context).uploadPostImage(dateTime: now.toLocal().toString(), text: postController.text);
                  SocialCubit.get(context).getPosts();
                  Navigator.pop(context);
                }


              },
              child: const Text(
                'POST',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                  const SizedBox(height: 10.0,),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060'),
                        radius: 25.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        'User Name',
                        style: TextStyle(height: 1.4, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: postController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What is on your mind ....'),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0,),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.grey[300],
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18.0,
                          ),
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.photo_camera_back),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {}, child: const Text('#tags',)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
