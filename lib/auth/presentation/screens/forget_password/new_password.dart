import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/domain/models/chec_code_model.dart';
import 'package:second_project/auth/domain/repos/auth_repo_impl.dart';
import 'package:second_project/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:second_project/auth/presentation/screens/login_screen.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key, required this.checkCodeModel});
  final CheckCodeModel checkCodeModel;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController repasswordEditingController =
      TextEditingController();
  Color passWordColor = Colors.white;

  @override
  void dispose() {
    super.dispose();
    passwordEditingController.dispose();
    repasswordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthResetPasswordSuccess) {
            Navigator.push(
              context,
              AnimationRoute(
                page: const LoginScreen(),
              ),
            );
          }
          if (state is AuthResetPasswordFaileur) {
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
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: AppPadding.homepadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppImages.rightArrow,
                          height: 40.r,
                        ),
                      ),
                      SizedBox(
                        height: 40.r,
                      ),
                      Text(
                        "New Password".tr(),
                        style: AppStyles.semiBold24,
                      ),
                      SizedBox(
                        height: 8.r,
                      ),
                      Text(
                        "Please enter the new password".tr(),
                        style: AppStyles.medium16,
                      ),
                      SizedBox(
                        height: 28.r,
                      ),
                      Text(
                        "New password".tr(),
                        style: AppStyles.regular14,
                      ),
                      SizedBox(
                        height: 8.r,
                      ),
                      TextFieldWidget(
                        visibleIcon: true,
                        hintText: 'كلمة المرور الجديدة',
                        textEditingController: passwordEditingController,
                      ),
                      SizedBox(
                        height: 8.r,
                      ),
                      Text(
                        "Confirm password".tr(),
                        style: AppStyles.regular12,
                      ),
                      SizedBox(
                        height: 12.r,
                      ),
                      TextFieldWidget(
                        visibleIcon: true,
                        hintText: 'اعادة كلمة المرور الجديدة',
                        textEditingController: repasswordEditingController,
                      ),
                      SizedBox(
                        height: 8.r,
                      ),
                      Text(
                        '! كلمة المرور غير متطابقة ',
                        style:
                            AppStyles.regular12.copyWith(color: passWordColor),
                      ),
                      SizedBox(
                        height: 36.r,
                      ),
                      ConfirmOrGoBackk(
                        onTap: () {
                          context.read<AuthCubit>().resetPassword(
                                password: passwordEditingController.text,
                                passwordConfirm:
                                    repasswordEditingController.text,
                                token: widget.checkCodeModel.resetToken ?? '',
                              );
                          setState(() {
                            if (passwordEditingController.text ==
                                repasswordEditingController.text) {
                              passWordColor = Colors.white;
                            } else {
                              passWordColor = Colors.red;
                            }
                          });
                        },
                        text: 'تأكيد',
                      ),
                    ],
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
