import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/presentation/screens/login_screen.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo_impl.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<ProfileRepoImpl>()),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogOutsuccess) {
            Navigator.of(context)
                .pushReplacement(AnimationRoute(page: const LoginScreen()));
          }
          if (state is LogOutFaileur) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.err.toString()),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 33),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you want to log out?".tr(),
                    style: AppStyles.semiBold24,
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      ConfirmOrGoBackk(
                        onTap: () {
                          context.read<ProfileCubit>().logOut();
                        },
                        text: 'Confirm'.tr(),
                        height: 40,
                        width: 120,
                      ),
                      12.horizontalSpace,
                      ConfirmOrGoBackk(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderColor: AppColors.secondColor,
                        backgroundColor: AppColors.whiteColor,
                        textColor: AppColors.secondColor,
                        text: 'Cancel'.tr(),
                        width: 120,
                        height: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
