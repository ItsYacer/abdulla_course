import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/social_layout.dart';
import 'package:test_new/modules/social_app/social_login/social_login_screen.dart';
import 'package:test_new/shared/components/components.dart';
import 'package:test_new/shared/bloc_observer.dart';
import 'package:test_new/shared/styles/themes.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  showToast(message: 'background', state: ToastState.SUCCESS);
}

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  debugPrint(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(message: 'on message', state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    debugPrint(event.data.toString());
    showToast(message: 'on message opened app', state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  Widget widget;

  uId = CacheHelper.getDate(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUser(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
        );
  }
}
