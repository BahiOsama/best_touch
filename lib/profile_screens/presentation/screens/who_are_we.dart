import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';

class WhoAreWe extends StatelessWidget {
  const WhoAreWe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Who We Are".tr()),
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
            children: [
              30.verticalSpace,
              Text(
                "Lorem Ipsum is simply dummy text (meaning the purpose is the form, not the content) used in printing and publishing industries. Lorem Ipsum has been the standard dummy text since the 15th century when an unknown printer arranged a set of letters randomly to form a booklet as a form or reference model. Five centuries of time did not eliminate this text; it even became used in its original form in printing and electronic typesetting. It spread widely in the 1960s with the release of plastic sheets containing excerpts from this text and has recently resurfaced with the emergence of electronic publishing programs like PageMaker, which also included versions of Lorem Ipsum."
                    .tr(),
                style: AppStyles.regular16,
              ),
            ],
          ),
        ));
  }
}
