import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.isNotEmpty ,
          builder: (context)=>ListView.separated(
            itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder:(context,index) =>myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
