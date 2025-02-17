import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/auth/presentation/screens/localization_Screen.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/local_data/shared_pref.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/bottom_nav_bar_screen.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:svg_image/svg_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (CashedSharedPrefrances.getData(key: 'token') != "") {
      BlocProvider.of<ProfileCubit>(context).getProfileData().then((v) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Navigator.of(context).pushReplacement(
                AnimationRoute(page: const BottomNavBarScreen()));
          },
        );
      });
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.of(context).pushReplacement(
              AnimationRoute(page: const LocaliziationScreen()));
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Center(
        child: SvgImage(AppImages.splashImage, type: PathType.assets),
      )),
    );
  }
}
