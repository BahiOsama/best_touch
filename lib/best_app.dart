import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/presentation/screens/splash_screen.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo_impl.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';

class BestApp extends StatelessWidget {
  const BestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<ProfileRepoImpl>()),
      child: ScreenUtilInit(
        designSize: const Size(411, 890),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.whiteColor,
                appBarTheme:
                    const AppBarTheme(backgroundColor: AppColors.whiteColor)),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
