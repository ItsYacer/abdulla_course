import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:test_new/shared/components/components.dart';
import 'package:test_new/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Add photos'),
                  ),
                ),
                Container(

                  color: Colors.grey[300],
                  child: TextButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        const EditProfileScreen(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Edit profile',style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10.0,),
                        Icon(
                          Icons.edit,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.subscribeToTopic('topic');
                      },
                      child: const Text('Sub'),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.unsubscribeFromTopic('topic');
                      },
                      child: const Text('un sub'),
                    ),
                  ],
                ),
                Container(
                  color: Colors.red,
                  width: double.infinity,
                  child: MaterialButton(

                    onPressed: () {
                      signOut(context);
                    },
                    child: const Text('sign out',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
