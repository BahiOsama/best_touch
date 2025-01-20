import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';

class CarWashStationShowDialog extends StatefulWidget {
  final Function(String sortNmae) onSortSelected;
  final String? initialSelectedOption;
  const CarWashStationShowDialog(
      {super.key, required this.onSortSelected, this.initialSelectedOption});
  @override
  State<CarWashStationShowDialog> createState() =>
      _CarWashStationShowDialogState();
}

List<String> options = [
  'All'.tr(),
  'Highest Rated'.tr(),
  'Nearest to You'.tr(),
];

class _CarWashStationShowDialogState extends State<CarWashStationShowDialog> {
  String? currentOption;
  @override
  void initState() {
    super.initState();
    currentOption = widget.initialSelectedOption ?? options[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppImages.close,
                ),
              ),
              90.horizontalSpace,
              Text(
                'Sort By'.tr(),
                style: AppStyles.medium18,
              ),
            ],
          ),
          15.verticalSpace,
          Row(
            children: List.generate(
              24,
              (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    child: Container(
                      width: 4,
                      height: 1.r,
                      color: AppColors.mainColor,
                    ),
                  ),
                );
              },
            ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentOption = options[index];
                      widget.onSortSelected(currentOption!);
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
                            Navigator.pop(context);

                            setState(() {
                              currentOption = value.toString();
                              widget.onSortSelected(currentOption!);
                            });
                          },
                        ),
                      ),
                      Text(
                        options[index],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
