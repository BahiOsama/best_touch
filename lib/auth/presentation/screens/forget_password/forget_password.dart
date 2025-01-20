import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/domain/repos/auth_repo_impl.dart';
import 'package:second_project/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:second_project/auth/presentation/screens/forget_password/otp_forget_password.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController phoneEditingController = TextEditingController();
  @override
  void dispose() {
    phoneEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthforgotPasswordSuccess) {
            Navigator.push(
              context,
              AnimationRoute(
                page: ForgetPassOTP(
                  phone: phoneEditingController.text,
                ),
              ),
            );
          }
          if (state is AuthforgotPasswordFaileur) {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppPadding.homepadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 22.r,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppImages.rightArrow,
                        ),
                      ),
                      SizedBox(
                        height: 36.r,
                      ),
                      Row(
                        children: [
                          Text(
                            "Forgot password".tr(),
                            style: AppStyles.semiBold24,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.r,
                      ),
                      Text("Please enter the registered phone number".tr(),
                          style: AppStyles.medium16),
                      SizedBox(
                        height: 28.r,
                      ),
                      Text(
                        "Phone number".tr(),
                        style: AppStyles.regular14,
                      ),
                      SizedBox(
                        height: 6.r,
                      ),
                      TextFieldWidget(
                        keyboardType: TextInputType.number,
                        textEditingController: phoneEditingController,
                        obsecureText: false,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16, left: 12).r,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppImages.saudiFlag,
                              ),
                              SizedBox(
                                width: 8.r,
                              ),
                              const Text(
                                '+966',
                              )
                            ],
                          ),
                        ),
                        hintText: "Enter phone number".tr(),
                      ),
                      SizedBox(
                        height: 36.r,
                      ),
                      ConfirmOrGoBackk(
                        onTap: () {
                          context.read<AuthCubit>().forgetPassword(
                              phone: phoneEditingController.text);
                        },
                        text: 'Next'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Image.asset(
              AppImages.wave,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
