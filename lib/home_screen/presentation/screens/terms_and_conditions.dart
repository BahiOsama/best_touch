import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Terms and Conditions".tr()),
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
        child: ListView(
          children: [
            Text(
              "Welcome to our app! We care about your privacy and want to provide you with a safe and reliable experience while using our app. Please read the following privacy policy to understand how we collect and use your personal data when using the app."
                  .tr(),
              style: AppStyles.regular16,
            ),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. ',
                  style: AppStyles.regular16,
                ),
                Expanded(
                  child: Text(
                    "Information Collection: We collect certain information about you when you use the app. This information may include your username, email address, device information, and details of your app usage."
                        .tr(),
                    style: AppStyles.regular16,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2. ',
                  style: AppStyles.regular16,
                ),
                Expanded(
                  child: Text(
                    "Information Usage: We use the information we collect to improve your experience with the app and provide better services. Other uses may also include contacting you for customer support and informing you about updates and special offers."
                        .tr(),
                    style: AppStyles.regular16,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3. ',
                  style: AppStyles.regular16,
                ),
                Expanded(
                  child: Text(
                    "Data Protection: We take security measures to protect your personal data and respect your privacy. We will not share your information with third parties without your explicit consent."
                        .tr(),
                    style: AppStyles.regular16,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4. ',
                  style: AppStyles.regular16,
                ),
                Expanded(
                  child: Text(
                    "User Rights: You have the right to access, correct, and delete your personal information if you wish. You can also withdraw your consent for data processing at any time."
                        .tr(),
                    style: AppStyles.regular16,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5. ',
                  style: AppStyles.regular16,
                ),
                Expanded(
                  child: Text(
                    "Privacy Policy Updates: We reserve the right to update this privacy policy from time to time. Any changes will be posted on this page, so it is recommended to review it periodically."
                        .tr(),
                    style: AppStyles.regular16,
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            Text(
              "Thank you for using our app, and we hope you enjoy your experience with us."
                  .tr(),
              style: AppStyles.regular16,
            )
          ],
        ),
      ),
    );
  }
}
