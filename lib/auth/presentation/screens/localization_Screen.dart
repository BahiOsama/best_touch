import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/presentation/screens/login_Screen.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:svg_image/svg_image.dart';

class LocaliziationScreen extends StatelessWidget {
  const LocaliziationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgImage(AppImages.smallLogo, type: PathType.assets),
          const Text('أهلا بيك فى Best Touch'),
          SizedBox(
            height: 32.r,
          ),
          InkWell(
            onTap: () {
              context.setLocale(const Locale('ar'));
              Navigator.pushReplacement(
                  context, AnimationRoute(page: const LoginScreen()));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20).r,
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              width: double.infinity,
              height: 48.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.secondColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppImages.mark),
                  Text(
                    'العربية',
                    style: AppStyles.regular16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 18.r,
          ),
          InkWell(
            onTap: () {
              context.setLocale(const Locale('en'));

              Navigator.pushReplacement(
                  context, AnimationRoute(page: const LoginScreen()));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20).r,
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.transperantBlack)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'English',
                    style: AppStyles.regular16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Image.asset(
        AppImages.wave,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
