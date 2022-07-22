import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/modules/social_app/social_register/cubit/cubit.dart';
import 'package:test_new/modules/social_app/social_register/cubit/state.dart';
import 'package:test_new/shared/components/components.dart';
import 'package:test_new/shared/components/constants.dart';
import 'package:test_new/shared/network/local/cache_helper.dart';

import '../../../layout/social_app/social_layout.dart';

// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: SocialRegisterCubit.get(context).registerModel.uId,
            ).then((value) {
              print(value.toString());
              SocialCubit.get(context).changeBottomNav(0);
              navigateAndFinish(context,const SocialLayout());
              SocialCubit.get(context).getUserData();
              SocialCubit.get(context).getPosts();
            });
            uId = CacheHelper.getDate(key: 'uId');
            navigateAndFinish(context, const SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.teal),
                        ),
                        Text(
                          'Register Now To communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        textField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                          label: 'Full Name',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        textField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email address';
                            }
                            return null;
                          },
                          prefixIcon: Icons.email,
                          label: 'Email Address',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        textField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:
                              SocialRegisterCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {
                            // if (formKey.currentState!.validate()) {
                            //   SocialRegisterCubit.get(context).loginUsers(
                            //       email: emailController.text,
                            //       password: passwordController.text);
                            // }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is to short';
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock,
                          suffixIcon: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          label: 'Password',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        textField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                            return null;
                          },
                          prefixIcon: Icons.phone,
                          label: 'phone',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                // debugPrint(emailController.text);
                                // debugPrint(passwordController.text);
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).registerUsers(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          password: passwordController.text);
                                }
                              },
                              text: 'LOGIN'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
