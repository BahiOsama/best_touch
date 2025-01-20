import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:second_project/auth/domain/repos/auth_repo_impl.dart';
import 'package:second_project/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:second_project/auth/presentation/screens/forget_password/new_password.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class ForgetPassOTP extends StatefulWidget {
  final String phone;
  const ForgetPassOTP({super.key, required this.phone});

  @override
  State<ForgetPassOTP> createState() => _ForgetPassOTPState();
}

class _ForgetPassOTPState extends State<ForgetPassOTP> {
  final TextEditingController codeController = TextEditingController();
  int resendTimer = 5;
  late Timer countDownTimer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countDownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          resendTimer = resendTimer - 1;
        });
        if (resendTimer < 1) {
          countDownTimer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthCheckCodeSuccess) {
            Navigator.push(
              context,
              AnimationRoute(
                page: NewPassword(
                  checkCodeModel: state.checkCodemModel,
                ),
              ),
            );
            print('state.checcodemodel.resetToken');

            print(state.checkCodemModel);
          }
          if (state is AuthCheckCodeFaileur) {
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
                padding: AppPadding.homepadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        AppImages.rightArrow,
                      ),
                    ),
                    SizedBox(
                      height: 50.r,
                    ),
                    Text(
                      "OTP Code".tr(),
                      style: AppStyles.semiBold24,
                    ),
                    SizedBox(
                      height: 8.r,
                    ),
                    Text(
                      "Please enter the code sent to ".tr(),
                      style: AppStyles.regular14,
                    ),
                    SizedBox(
                      height: 8.r,
                    ),
                    Text(
                      widget.phone,
                      style: AppStyles.regular14
                          .copyWith(color: AppColors.secondColor),
                    ),
                    SizedBox(
                      height: 6.r,
                    ),
                    Center(
                      child: Pinput(
                        controller: codeController,
                        length: 4,
                        defaultPinTheme: PinTheme(
                          width: 75.0.r,
                          height: 75.0.r,
                          textStyle: TextStyle(
                            fontSize: 22.r,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: AppColors.secondColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 34.r,
                    ),
                    ConfirmOrGoBackk(
                      onTap: () {
                        context.read<AuthCubit>().chechCode(
                            phone: widget.phone, code: codeController.text);
                      },
                      text: 'التالى',
                    ),
                    SizedBox(
                      height: 22.r,
                    ),
                    resendTimer == 0
                        ? Center(
                            child: InkWell(
                              child: Text(
                                "Resend".tr(),
                                style: AppStyles.semiBold14
                                    .copyWith(color: AppColors.secondColor),
                              ),
                              onTap: () {
                                context.read<AuthCubit>().resendResetCode(
                                      phone: widget.phone,
                                    );
                                resendTimer = 5;
                                startTimer();
                              },
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Resend code after ".tr(),
                                style: AppStyles.medium16,
                              ),
                              Text(
                                "$resendTimer ",
                                style: AppStyles.medium16
                                    .copyWith(color: AppColors.secondColor),
                              ),
                              Text(
                                "Second".tr(),
                                style: AppStyles.medium16,
                              ),
                            ],
                          ),
                  ],
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
