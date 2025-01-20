import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/home_screen/presentation/screens/home_screen.dart';
import 'package:second_project/home_screen/presentation/screens/reservations.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

List list = [
  const HomeScreen(),
  const Reservations(),
];

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        curve: Curves.bounceIn,
        duration: const Duration(microseconds: 500),
        height: 100.r,
        child: BottomNavigationBar(
          unselectedItemColor: AppColors.transperantBlack,
          unselectedIconTheme: const IconThemeData(
            color: AppColors.secondColor,
          ),
          backgroundColor: Colors.white,
          selectedFontSize: 16.r,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.secondColor,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 33.r,
                child: Icon(
                  size: 32,
                  Icons.home,
                  color: currentIndex == 0
                      ? AppColors.secondColor
                      : AppColors.transperantBlack,
                ),
              ),
              label: 'Home Page'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 33.r,
                child: Icon(
                  size: 32,
                  Icons.access_time,
                  color: currentIndex == 1
                      ? AppColors.secondColor
                      : AppColors.transperantBlack,
                ),
              ),
              label: 'Bookings'.tr(),
            ),
          ],
        ),
      ),
      body: PageTransitionSwitcher(
        child: list[currentIndex],
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeTransition(
          opacity: primaryAnimation,
          child: child,
        ),
      ),
    );
  }
}
