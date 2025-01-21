import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/domain/repos/auth_repo_impl.dart';
import 'package:second_project/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:second_project/auth/presentation/screens/forget_password/forget_password.dart';
import 'package:second_project/auth/presentation/screens/register_screen.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/home_screen.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    phoneEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            BlocProvider.of<ProfileCubit>(context).getProfileData();
            Navigator.pushReplacement(
              context,
              AnimationRoute(
                page: const HomeScreen(),
              ),
            );
          }
          if (state is AuthLoginFaileur) {
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
            body: Form(
              autovalidateMode: autovalidateMode,
              key: formKey,
              child: SafeArea(
                child: Padding(
                  padding: AppPadding.homepadding,
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Continue as Guest".tr(),
                              style: AppStyles.medium14
                                  .copyWith(color: AppColors.transperantBlack),
                            ),
                            SizedBox(
                              width: 6.r,
                            ),
                            Image.asset(AppImages.leftArrow),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.r,
                      ),
                      Text(
                        "Login".tr(),
                        style: AppStyles.semiBold24,
                      ),
                      Text(
                        "Please enter phone number and password".tr(),
                        style: AppStyles.regular16,
                      ),
                      SizedBox(
                        height: 24.r,
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
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Please Enter Valid ';
                          } else {
                            return null;
                          }
                        },
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
                        height: 6.r,
                      ),
                      // Text(
                      //   "Invalid phone number".tr(),
                      //   style:
                      //       AppStyles.regular12.copyWith(color: AppColors.redColor),
                      // ),
                      SizedBox(
                        height: 14.r,
                      ),
                      Text(
                        "Password".tr(),
                        style: AppStyles.regular14,
                      ),
                      SizedBox(
                        height: 6.r,
                      ),
                      TextFieldWidget(
                        textEditingController: passwordEditingController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Please Enter Valid ';
                          } else {
                            return null;
                          }
                        },
                        visibleIcon: true,
                        hintText: "Enter password".tr(),
                        suffixIcon: const Icon(
                          Icons.visibility_off,
                          color: Colors.black26,
                        ),
                        prefixIcon: Image.asset(
                          AppImages.unlock,
                        ),
                      ),
                      SizedBox(
                        height: 12.r,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  AnimationRoute(page: const ForgotPassword()));
                            },
                            child: Text(
                              "Forgot password?".tr(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 44.r,
                      ),
                      state is AuthLoginLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ConfirmOrGoBackk(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  String? deviceToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  context.read<AuthCubit>().login(
                                        deviceToken: deviceToken,
                                        password:
                                            passwordEditingController.text,
                                        phone: phoneEditingController.text,
                                      );
                                } else {
                                  setState(() {
                                    autovalidateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                              text: "Log In".tr(),
                            ),

                      SizedBox(
                        height: 16.r,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?".tr(),
                            style: AppStyles.semiBold14,
                          ),
                          SizedBox(
                            width: 3.r,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  AnimationRoute(page: const RegisterScreen()));
                            },
                            child: Text(
                              "Create new account".tr(),
                              style: AppStyles.semiBold14
                                  .copyWith(color: AppColors.secondColor),
                            ),
                          )
                        ],
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
