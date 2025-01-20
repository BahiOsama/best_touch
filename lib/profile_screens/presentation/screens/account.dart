import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/profile_screens/presentation/screens/about.dart';
import 'package:second_project/profile_screens/presentation/screens/change_password.dart';
import 'package:second_project/profile_screens/presentation/screens/contact_with_us.dart';
import 'package:second_project/profile_screens/presentation/screens/language.dart';
import 'package:second_project/profile_screens/presentation/screens/profile_package.dart';
import 'package:second_project/profile_screens/presentation/screens/wallet.dart';
import 'package:second_project/profile_screens/presentation/widgets/about_app_widget.dart';
import 'package:second_project/profile_screens/presentation/widgets/profileWidget.dart';
import 'package:second_project/profile_screens/presentation/widgets/sighOutWidget.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

bool switchValue = false;

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Account".tr()),
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
            ////////
            const ProfileWidget(),
            ///////
            20.verticalSpace,
            AboutAppWidget(
              leadingImg: AppImages.wallet,
              text: "Wallet",
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const Wallet()));
              },
            ),
            14.verticalSpace,
            AboutAppWidget(
              leadingImg: AppImages.package,
              text: "Subscribed Packages",
              onTap: () {
                Navigator.of(context).push(
                  AnimationRoute(
                    page: const ProfilePackages(),
                  ),
                );
              },
            ),
            14.verticalSpace,
            AboutAppWidget(
              trailing: Switch(
                activeColor: Colors.green,
                value: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
              leadingImg: AppImages.notification,
              text: "Notifications",
              onTap: () {},
            ),
            14.verticalSpace,
            AboutAppWidget(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.locale == const Locale('en')
                      ? "English".tr()
                      : "Arabic".tr()),
                  10.horizontalSpace,
                  Image.asset(AppImages.leftarrow2),
                ],
              ),
              leadingImg: AppImages.language,
              text: "Language",
              onTap: () {
                Navigator.of(context).push(AnimationRoute(
                    page: const LocaliziationScreenForProfile()));
              },
            ),
            14.verticalSpace,
            AboutAppWidget(
              leadingImg: AppImages.call,
              text: "Contact Us",
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const ContactWithUs()));
              },
            ),
            14.verticalSpace,
            AboutAppWidget(
              leadingImg: AppImages.faqs,
              text: "About the App",
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const AboutApp()));
              },
            ),
            14.verticalSpace,
            AboutAppWidget(
              leadingImg: AppImages.privacypolice,
              text: "Change Password",
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const ChangePassword()));
              },
            ),
            14.verticalSpace,
            AboutAppWidget(
              trailing: const Text(''),
              leadingImg: AppImages.logout,
              text: "Log Out",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const SignOutWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
