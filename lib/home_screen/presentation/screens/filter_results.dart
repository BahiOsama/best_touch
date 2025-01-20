import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';

class FilterResults extends StatefulWidget {
  const FilterResults({super.key});

  @override
  State<FilterResults> createState() => _FilterResultsState();
}

List<String> options = [
  'option1',
  'option2',
  'option3',
  'option4',
  'option5',
  'option6',
];
String currentOption = options[0];

class _FilterResultsState extends State<FilterResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: AppPadding.appbarpadding,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Reset'.tr(),
                style:
                    AppStyles.medium18.copyWith(color: AppColors.secondColor),
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Text("Filter Results".tr()),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentOption = options[index];
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Radio(
                              value: options[index],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                          Image.asset(
                            AppImages.smallPhotoForHomeScreennn,
                          ),
                          const SizedBox(width: 8),
                          const Text('كلين أوف')
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            15.verticalSpace,
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Car Size'.tr(),
                    style: AppStyles.semiBold16,
                  ),
                  Image.asset(AppImages.down),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
