import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/models/social_app/post_model.dart';
import 'package:test_new/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty  && SocialCubit.get(context).userModel != null  ,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg?w=996'),
                        fit: BoxFit.fill,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 26.0),
                        child: Text(
                          'Communicate With Friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Colors.redAccent,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).posts[index], context,index),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                    itemCount: SocialCubit.get(context).posts.length),
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
