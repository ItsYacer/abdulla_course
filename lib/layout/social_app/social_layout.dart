import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/modules/social_app/add_post/add_post_screen.dart';
import 'package:test_new/modules/social_app/search/search_screen.dart';
import 'package:test_new/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          navigateTo(context, const AddPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(color: Colors.grey),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showToast(message: 'notification will add soon', state: ToastState.SUCCESS);
                  },
                  icon: const Icon(Icons.notifications_active)),
              IconButton(
                  onPressed: () {
                    cubit.getAllUser();
                    navigateTo(context, SearchScreen());
                  }, icon: const Icon(Icons.search_rounded)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            selectedItemColor: Colors.greenAccent,
            items: cubit.items,
          ),
        );
      },
    );
  }
}
