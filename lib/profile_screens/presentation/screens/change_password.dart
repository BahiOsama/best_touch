import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo_impl.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
  });

  @override
  State<ChangePassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<ChangePassword> {
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController newpasswordEditingController =
      TextEditingController();
  final TextEditingController reNewpasswordEditingController =
      TextEditingController();
  final TextEditingController oldpasswordEditingController =
      TextEditingController();
  Color passWordColor = Colors.white;

  @override
  void dispose() {
    super.dispose();
    newpasswordEditingController.dispose();
    reNewpasswordEditingController.dispose();
    oldpasswordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<ProfileRepoImpl>()),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileAndChangePasswordsuccess) {
            Fluttertoast.showToast(
                msg: "Password Change Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColors.secondColor,
                textColor: AppColors.whiteColor,
                fontSize: 14.0);
            newpasswordEditingController.clear();
            reNewpasswordEditingController.clear();
            oldpasswordEditingController.clear();
          }
          if (state is EditProfileAndChangePasswordFaileur) {
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
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Change Password".tr()),
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
              body: Form(
                autovalidateMode: autovalidateMode,
                key: formKey,
                child: Padding(
                  padding: AppPadding.homepadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        15.verticalSpace,
                        Text(
                          "Old Password".tr(),
                          style: AppStyles.regular14,
                        ),
                        SizedBox(
                          height: 8.r,
                        ),
                        TextFieldWidget(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please Enter Valid ';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Image.asset(AppImages.unlock),
                          visibleIcon: true,
                          hintText: "Old Password".tr(),
                          textEditingController: oldpasswordEditingController,
                        ),
                        15.verticalSpace,
                        const Divider(),
                        SizedBox(
                          height: 14.r,
                        ),
                        Text(
                          "New password".tr(),
                          style: AppStyles.regular12,
                        ),
                        10.verticalSpace,
                        TextFieldWidget(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please Enter Valid ';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Image.asset(AppImages.unlock),
                          visibleIcon: true,
                          hintText: "Enter Password".tr(),
                          textEditingController: newpasswordEditingController,
                        ),
                        SizedBox(
                          height: 8.r,
                        ),
                        Text(
                          "Passwords do not match".tr(),
                          style: AppStyles.regular12
                              .copyWith(color: passWordColor),
                        ),
                        10.verticalSpace,
                        Text(
                          "Confirm New Password".tr(),
                          style: AppStyles.regular12,
                        ),
                        10.verticalSpace,
                        TextFieldWidget(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please Enter Valid ';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Image.asset(AppImages.unlock),
                          visibleIcon: true,
                          hintText: "Enter Password".tr(),
                          textEditingController: reNewpasswordEditingController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 26),
                child: state is EditProfileAndChangePasswordLoading
                    ? LoadingAnimationWidget.flickr(
                        leftDotColor: AppColors.secondColor,
                        rightDotColor: AppColors.whiteColor,
                        size: 50.r,
                      )
                    : ConfirmOrGoBackk(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (newpasswordEditingController.text ==
                                reNewpasswordEditingController.text) {
                              setState(() {
                                passWordColor = Colors.white;
                                autovalidateMode = AutovalidateMode.disabled;
                              });

                              context
                                  .read<ProfileCubit>()
                                  .editProfileAndChangePassword(
                                    oldpassword:
                                        oldpasswordEditingController.text,
                                    password: newpasswordEditingController.text,
                                    confirmPassword:
                                        reNewpasswordEditingController.text,
                                  );
                            } else {
                              setState(() {
                                passWordColor = Colors.red;
                              });
                            }
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        text: "Edit".tr(),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
