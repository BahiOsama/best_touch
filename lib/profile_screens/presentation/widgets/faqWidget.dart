import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';

class FAQWidget extends StatefulWidget {
  const FAQWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title, subTitle;

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              hide = !hide;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  style: AppStyles.regular16,
                  widget.title,
                ),
              ),
              hide ? Image.asset(AppImages.down) : Image.asset(AppImages.up),
            ],
          ),
        ),
        14.verticalSpace,
        hide
            ? Text(
                widget.subTitle,
                style: AppStyles.regular16,
              )
            : const SizedBox(),
        8.verticalSpace
      ],
    );
  }
}
