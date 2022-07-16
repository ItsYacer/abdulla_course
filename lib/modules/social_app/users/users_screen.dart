import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/models/social_app/post_model.dart';
import 'package:test_new/shared/components/components.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PostModel> myPosts = [];
      for(var element in SocialCubit.get(context).posts){
        if(element.uId== SocialCubit.get(context).userModel!.uId){
          myPosts.add(element);
        }
      }
      print(SocialCubit.get(context).posts.toString());
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {
      },
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 220.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 160.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(model!.cover),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      CircleAvatar(
                        radius: 67.0,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(model.image),
                          radius: 65.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(model.name, style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 5.0,
                ),
                Text(model.bio, style: Theme.of(context).textTheme.caption),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('Post',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('89',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('Photo',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('101k',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('Followers',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('89',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('Following',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                if (myPosts.isNotEmpty)
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(myPosts[index], context, index),
                      separatorBuilder: (context, index) => const SizedBox(height: 8.0,),
                      itemCount: myPosts.length),
                SizedBox(height: 20.0,),
                if (myPosts.isEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        child: const Center(
                            child: Text(
                          'Not Posts Yet ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )),
                      ),
                      TextButton(onPressed: () {}, child: const Text('add post'))
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
