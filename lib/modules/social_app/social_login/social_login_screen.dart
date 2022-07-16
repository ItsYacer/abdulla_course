import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/social_layout.dart';
import 'package:test_new/modules/social_app/social_login/cubit/cubit.dart';
import 'package:test_new/modules/social_app/social_login/cubit/state.dart';
import 'package:test_new/modules/social_app/social_register/shop_register_screen.dart';
import 'package:test_new/shared/components/components.dart';
import 'package:test_new/shared/components/constants.dart';
import 'package:test_new/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(message: state.error, state: ToastState.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId,).then((value) {
              print(value.toString());
              SocialCubit.get(context).changeBottomNav(0);
              navigateAndFinish(context,const SocialLayout());
              SocialCubit.get(context).getUserData();
              SocialCubit.get(context).getPosts();
            });
            uId=CacheHelper.getDate(key: 'uId');
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.teal),
                        ),
                        Text(
                          'Login Now For Communicate With Friends',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
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
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).loginUsers(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is to short';
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock,
                          suffixIcon: SocialLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          label: 'Password',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                // debugPrint(emailController.text);
                                // debugPrint(passwordController.text);
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).loginUsers(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'LOGIN'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account? '),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              text: 'register now ',
                            ),
                          ],
                        )
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
