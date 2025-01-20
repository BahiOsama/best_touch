import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class RateUs extends StatefulWidget {
  const RateUs({super.key});

  @override
  State<RateUs> createState() => _RateUsState();
}

final TextEditingController texteditingController = TextEditingController();

class _RateUsState extends State<RateUs> {
  int selectedStarIndex = 0;
  @override
  void dispose() {
    texteditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Rate the Order".tr()),
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: AppPadding.homepadding,
            child: Column(
              children: [
                50.verticalSpace,
                Text(
                  "Rate Us".tr(),
                  style: AppStyles.medium18,
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < selectedStarIndex
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedStarIndex = index + 1;
                          });
                        },
                      );
                    },
                  ),
                ),
                60.verticalSpace,
                Text(
                  'Leave Your Comment'.tr(),
                  style: AppStyles.medium18,
                ),
                20.verticalSpace,
                TextField(
                  controller: texteditingController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.all(Radius.circular(8.r))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.secondColor),
                        borderRadius: BorderRadius.all(Radius.circular(8.r))),
                    filled: true,
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.redColor)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(14.r),
        child: ConfirmOrGoBackk(
          text: 'Done'.tr(),
          onTap: () {
            texteditingController.clear();

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
                        'Thank you for your rating'.tr(),
                        style: AppStyles.semiBold24,
                      ),
                      Image.asset(AppImages.thankU),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
