import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/modules/social_app/users/users_screen.dart';
import 'package:test_new/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        nameController.text = model!.name;
        bioController.text = model.bio;
        phoneController.text = model.phone;
        final profileImage = SocialCubit.get(context).profileImage;
        final coverImage = SocialCubit.get(context).coverImage;

        return WillPopScope(
          onWillPop: () async {
            debugPrint('back button pressed!');
            final shouldPop = await showWarning(context);

            return shouldPop ?? false;
          },
          child: Scaffold(
            appBar: buildDefaultAppBar(
              context: context,
              title: 'Edit Profile',
              action: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialLoadingUserState)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 220.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 160.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0),
                                      ),
                                      image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(model.cover)
                                            : FileImage(coverImage)
                                                as ImageProvider,
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
                                        Icons.camera_alt_outlined,
                                        size: 18.0,
                                      ),
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getCoverImage();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 67.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(model.image)
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                  radius: 65.0,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.grey[300],
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 18.0,
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              bio: bioController.text,
                                              phone: phoneController.text);
                                      Navigator.pop(context);
                                    },
                                    text: 'Upload Profile '),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                if (state is SocialGetUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            )),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          bio: bioController.text,
                                          phone: phoneController.text);
                                      Navigator.pop(context);
                                    },
                                    text: 'Upload Cover '),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                if (state is SocialGetUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            )),
                        ],
                      ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    textField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        label: 'New Name',
                        prefixIcon: Icons.person_pin,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please Enter New Name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    textField(
                        controller: bioController,
                        keyboardType: TextInputType.text,
                        label: 'your bio',
                        prefixIcon: Icons.person_pin,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please Enter your bio';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    textField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      label: 'Phone',
                      prefixIcon: Icons.call,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please Entre your phone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Changes on this page will not be saved'),
          title: Text('Discard Changes ?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Discard')),
          ],
        ),
      );
}
