import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';

class ConfirmOrGoBackk extends StatelessWidget {
  const ConfirmOrGoBackk({
    super.key,
    required this.text,
    this.textColor,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
  });
  final String text;
  final Color? textColor, backgroundColor, borderColor;
  final Function()? onTap;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.transparent),
            color: backgroundColor ?? AppColors.secondColor,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        width: width ?? double.infinity,
        height: height ?? 54.r,
        child: Center(
          child: Text(
            text,
            style: AppStyles.regular16
                .copyWith(color: textColor ?? AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
