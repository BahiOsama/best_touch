import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(getIt.get<HomeRepoImp>())..getNotification(),
      child: BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          if (state is GetNotificationsuccess) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Notifications".tr()),
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
                child: ListView.builder(
                  itemCount: state.notificationModel.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'اليوم'.tr(),
                                style: AppStyles.semiBold16,
                              ),
                              5.verticalSpace,
                              Image.asset(AppImages.smallPhotoForHomeScreenn),
                            ],
                          ),
                          10.horizontalSpace,
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 26.r,
                                ),
                                Text(
                                  state.notificationModel[index].title,
                                ),
                                Text(
                                  state.notificationModel[index].message,
                                ),
                                7.verticalSpace,
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.timeCircl,
                                      color: AppColors.transperantBlack,
                                    ),
                                    5.horizontalSpace,
                                    Text(
                                      state.notificationModel[index]
                                          .createdAtFormatted,
                                      style: AppStyles.medium14.copyWith(
                                        color: AppColors.transperantBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 32.r,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                    ),
                                  ),
                                  backgroundColor: const WidgetStatePropertyAll(
                                    AppColors.secondColor,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Pay'.tr(),
                                  style: AppStyles.medium14
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      25.verticalSpace,
                      Row(
                        children: List.generate(
                          24,
                          (index) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.r),
                                child: Container(
                                  height: 1.r,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      15.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetNotificationLoading) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: AppColors.secondColor,
                  rightDotColor: AppColors.whiteColor,
                  size: 50.r,
                ),
              ),
            );
          } else {
            return const Text('data');
          }
        },
      ),
    );
  }
}
