import 'package:test_new/modules/social_app/social_login/social_login_screen.dart';
import 'package:test_new/shared/components/components.dart';
import 'package:test_new/shared/network/local/cache_helper.dart';

void signOut(context) =>CacheHelper.clearData(key: 'uId').then((value) {
  navigateAndFinish(context, SocialLoginScreen());
});

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? uId = '' ;