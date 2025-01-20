import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/auth/domain/repos/auth_repo_impl.dart';
import 'package:second_project/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:second_project/auth/presentation/screens/google_maps.dart';
import 'package:second_project/auth/presentation/screens/verifi_the_acc.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final TextEditingController nameEditingController = TextEditingController();
final TextEditingController passwordEditingController = TextEditingController();
final TextEditingController repasswordEditingController =
    TextEditingController();
final TextEditingController phoneEditingController = TextEditingController();
final TextEditingController positionEditingController = TextEditingController();

var formKey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
double? latitude;
double? longitude;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistSuccess) {
            Navigator.pushReplacement(
              context,
              AnimationRoute(
                page: VerifiTheAcc(
                  phone: phoneEditingController.text,
                ),
              ),
            );
          }
          if (state is AuthRegistFaileur) {
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
                        height: 40.r,
                      ),
                      Text(
                        "Create new account".tr(),
                        style: AppStyles.semiBold24,
                      ),
                      Text(
                        "Please fill in the required fields".tr(),
                        style: AppStyles.medium16,
                      ),
                      SizedBox(
                        height: 24.r,
                      ),
                      Text(
                        "Username".tr(),
                        style: AppStyles.regular12,
                      ),
                      SizedBox(height: 6.r),
                      TextFieldWidget(
                        textEditingController: nameEditingController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please Enter Valid Name';
                          } else {
                            return null;
                          }
                        },
                        obsecureText: false,
                        hintText: "Username".tr(),
                      ),
                      SizedBox(
                        height: 16.r,
                      ),
                      Text(
                        "Phone number".tr(),
                        style: AppStyles.regular12,
                      ),
                      SizedBox(height: 6.r),
                      TextFieldWidget(
                        textEditingController: phoneEditingController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Please Enter Valid Phone';
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
                        height: 16.r,
                      ),
                      Text(
                        "Password".tr(),
                        style: AppStyles.regular12,
                      ),
                      SizedBox(height: 6.r),
                      TextFieldWidget(
                        textEditingController: passwordEditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Please Enter Valid Password';
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
                      ),
                      SizedBox(
                        height: 16.r,
                      ),
                      Text(
                        "Confirm password".tr(),
                        style: AppStyles.regular12,
                      ),
                      SizedBox(height: 6.r),
                      TextFieldWidget(
                        textEditingController: repasswordEditingController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Please Enter Valid Password';
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
                      ),
                      SizedBox(
                        height: 16.r,
                      ),
                      Row(
                        children: [
                          Text(
                            "Location".tr(),
                            style: AppStyles.regular12,
                          ),
                          SizedBox(
                            width: 4.r,
                          ),
                          Text(
                            "Optional".tr(),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.r),
                      InkWell(
                        onTap: () async {
                          final locationData = await Navigator.of(context).push(
                            AnimationRoute(
                              page: BlocProvider(
                                create: (context) =>
                                    AuthCubit(getIt.get<AuthRepoImpl>()),
                                child: const GoogleMapsScreen(),
                              ),
                            ),
                          );

                          if (locationData != null) {
                            setState(() {
                              positionEditingController.text =
                                  locationData['address'].toString();

                              latitude = locationData['latitude'];
                              longitude = locationData['longitude'];
                            });
                          }
                        },
                        child: TextFieldWidget(
                          textEditingController: positionEditingController,
                          enabled: false,
                          obsecureText: false,
                          hintText: "SetLocation".tr(),
                        ),
                      ),
                      SizedBox(
                        height: 32.r,
                      ),
                      ConfirmOrGoBackk(
                        text: "Register Now".tr(),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                                  location: positionEditingController.text,
                                  lat: latitude.toString(),
                                  long: longitude.toString(),
                                  name: nameEditingController.text,
                                  password: passwordEditingController.text,
                                  rePassword: repasswordEditingController.text,
                                  phone: phoneEditingController.text,
                                );
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.r,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?".tr(),
                            style: AppStyles.semiBold14,
                          ),
                          SizedBox(
                            width: 3.r,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Log In".tr(),
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
