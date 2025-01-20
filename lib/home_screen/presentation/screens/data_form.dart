import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/terms_and_conditions.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  TextEditingController phoneEditingController = TextEditingController();
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Data Form".tr()),
        leading: Padding(
          padding: AppPadding.appbarpadding,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppImages.close,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: AppPadding.appbarpadding,
        child: ListView(
          children: [
            15.verticalSpace,
            Padding(
              padding: EdgeInsets.only(right: 4.r),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.aboutus,
                  ),
                  10.horizontalSpace,
                  Text(
                    'Please fill in the following details'.tr(),
                    style: AppStyles.medium14
                        .copyWith(color: AppColors.transperantBlack),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Text(
              "Car Owner's Name".tr(),
              style: AppStyles.medium16,
            ),
            8.verticalSpace,
            TextFieldWidget(
              hintText: "Car Owner's Name".tr(),
              textColor: AppColors.transperantBlack,
            ),
            20.verticalSpace,
            Text(
              "Enter phone number".tr(),
              style: AppStyles.medium16,
            ),
            8.verticalSpace,
            TextFieldWidget(
              keyboardType: TextInputType.number,
              textEditingController: phoneEditingController,
              validator: (value) {
                if (value!.isEmpty || value.length < 10) {
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
            20.verticalSpace,
            Text(
              "Car Plate".tr(),
              style: AppStyles.medium16,
            ),
            8.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Letters'.tr(),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.transperantBlack)),
                    ),
                  ),
                ),
                SizedBox(width: 10.r),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Numbers'.tr(),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.transperantBlack)),
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              "Car Model".tr(),
              style: AppStyles.medium16,
            ),
            8.verticalSpace,
            TextFieldWidget(
              hintText: "Car Model".tr(),
              textColor: AppColors.transperantBlack,
            ),
            20.verticalSpace,
            Text(
              "Car Type".tr(),
              style: AppStyles.medium16,
            ),
            8.verticalSpace,
            TextFieldWidget(
              hintText: "Car Type".tr(),
              textColor: AppColors.transperantBlack,
            ),
            25.verticalSpace,
            Text(
              "Please take some pictures of the car".tr(),
              style: AppStyles.medium16,
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.uploadPhoto),
                15.horizontalSpace,
                Image.asset(AppImages.car2),
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: Colors.green,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusColor: AppColors.whiteColor,
                  side: const BorderSide(color: AppColors.transperantBlack),
                  value: isAgreed,
                  onChanged: (value) {
                    setState(() {
                      isAgreed = value!;
                    });
                  },
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please note that clicking this will accept the'.tr(),
                      style: AppStyles.medium16
                          .copyWith(color: AppColors.transperantBlack),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            AnimationRoute(page: const TermsAndConditions()));
                      },
                      child: Text(
                        'Terms and Conditions'.tr(),
                        style: AppStyles.medium14
                            .copyWith(color: AppColors.secondColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
            30.verticalSpace,
            ConfirmOrGoBackk(
              text: 'Pay'.tr(),
              onTap: () {
                if (!isAgreed) {
                  Fluttertoast.showToast(
                    msg: 'You must agree to the Terms and Conditions to proceed'
                        .tr(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0.r,
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });

                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'Your request has been successfully sent. Please wait for a response'
                                  .tr(),
                              style: AppStyles.semiBold24,
                            ),
                            Image.asset(AppImages.success),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
