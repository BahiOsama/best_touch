import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/presentation/screens/login_Screen.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo_impl.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class DeleteAcc extends StatefulWidget {
  const DeleteAcc({super.key});

  @override
  State<DeleteAcc> createState() => _DeleteAccState();
}

class _DeleteAccState extends State<DeleteAcc> {
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  void dispose() {
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        getIt.get<ProfileRepoImpl>(),
      ),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is DeleteAccsuccess) {
            Navigator.of(context).pushReplacement(
              AnimationRoute(
                page: const LoginScreen(),
              ),
            );
          }
          if (state is DeleteAccFaileur) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    state.err.toString(),
                  ),
                );
              },
            );
          } else {
            Container();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Delete Account".tr()),
              leading: Padding(
                padding: AppPadding.appbarpadding,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    AppImages.rightArrow,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: AppPadding.homepadding,
              child: ListView(
                children: [
                  30.verticalSpace,
                  15.verticalSpace,
                  Text(
                    "Enter Password".tr(),
                    style: AppStyles.regular14,
                  ),
                  3.verticalSpace,
                  TextFieldWidget(
                    obsecureText: false,
                    textEditingController: passwordTextEditingController,
                    prefixIcon: Image.asset(
                      AppImages.gmail,
                      color: Colors.black26,
                    ),
                    hintText: "Enter Password".tr(),
                  ),
                  35.verticalSpace,
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 33)
                                .r,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Delete Account".tr(),
                                  style: AppStyles.semiBold24,
                                ),
                                25.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConfirmOrGoBackk(
                                      onTap: () {
                                        context.read<ProfileCubit>().deleteAcc(
                                            password:
                                                passwordTextEditingController
                                                    .text);
                                      },
                                      text: 'Confirm'.tr(),
                                      height: 40.r,
                                      width: 120.r,
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
                                      width: 120.r,
                                      height: 40.r,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.delete,
                        ),
                        5.horizontalSpace,
                        Text(
                          "Delete Account".tr(),
                          style: AppStyles.regular14
                              .copyWith(color: AppColors.redColor),
                        ),
                      ],
                    ),
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
