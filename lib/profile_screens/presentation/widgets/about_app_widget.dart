import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';

class AboutAppWidget extends StatelessWidget {
  const AboutAppWidget({
    super.key,
    required this.text,
    required this.leadingImg,
    this.onTap,
    this.trailing,
  });
  final String text, leadingImg;
  final void Function()? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.whiteColor,
        elevation: 2,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListTile(
            title: Text(
              text.tr(),
            ),
            leading: Image.asset(leadingImg),
            trailing: trailing ?? Image.asset(AppImages.leftarrow2),
          ),
        ),
      ),
    );
  }
}
