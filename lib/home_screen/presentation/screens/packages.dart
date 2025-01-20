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
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/screens/filter_results.dart';
import 'package:second_project/home_screen/presentation/widgets/choose_washer_dialog.dart';
import 'package:second_project/home_screen/presentation/widgets/monthly_packages_widget.dart';
import 'package:second_project/home_screen/presentation/widgets/public_packages_widget.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  bool isCurrentSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Packages".tr()),
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
      body: BlocProvider(
        create: (context) => HomeCubit(
          getIt.get<HomeRepoImp>(),
        )..getAPackages(),
        child: BlocBuilder<HomeCubit, HomeCubitState>(
          builder: (context, state) {
            if (state is GetPackagesSuccess) {
              return Padding(
                padding: AppPadding.homepadding,
                child: Column(
                  children: [
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConfirmOrGoBackk(
                          onTap: () {
                            setState(() {
                              isCurrentSelected = true;
                            });
                          },
                          text: 'General'.tr(),
                          backgroundColor: isCurrentSelected
                              ? AppColors.secondColor
                              : AppColors.secondColor.withOpacity(.13),
                          textColor: isCurrentSelected
                              ? AppColors.whiteColor
                              : AppColors.transperantBlack,
                          width: 185,
                          height: 45,
                        ),
                        ConfirmOrGoBackk(
                          onTap: () {
                            setState(() {
                              isCurrentSelected = false;
                            });
                          },
                          backgroundColor: isCurrentSelected
                              ? AppColors.secondColor.withOpacity(.13)
                              : AppColors.secondColor,
                          textColor: isCurrentSelected
                              ? AppColors.transperantBlack
                              : AppColors.whiteColor,
                          text: 'Monthly'.tr(),
                          width: 185,
                          height: 45,
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    isCurrentSelected
                        ? Row(
                            children: [
                              Image.asset(
                                AppImages.hint,
                              ),
                              5.horizontalSpace,
                              Text(
                                'Get 25% free extra credit when purchasing a package'
                                    .tr(),
                                style: AppStyles.medium14.copyWith(
                                    color: AppColors.transperantBlack),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              const ChooseWasherDialog(),
                              10.horizontalSpace,
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(AnimationRoute(
                                      page: const FilterResults()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        AppColors.secondColor.withOpacity(.1),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(AppImages.filter),
                                      5.horizontalSpace,
                                      Text(
                                        'Filter Results'.tr(),
                                        style: AppStyles.regular14.copyWith(
                                            color: AppColors.secondColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    20.verticalSpace,
                    isCurrentSelected
                        ? Expanded(
                            child: GridView.builder(
                              itemCount: 20,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 3,
                                      crossAxisSpacing: 1,
                                      childAspectRatio: 1.4,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return const PublicPackagesWidget();
                              },
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 12,
                              ),
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return const MonthlyPackagesWidget();
                              },
                            ),
                          )
                  ],
                ),
              );
            } else if (state is GetPackagesLoading) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: AppColors.secondColor,
                  rightDotColor: AppColors.whiteColor,
                  size: 50,
                ),
              );
            } else {
              return const Text('Faileur ...');
            }
          },
        ),
      ),
    );
  }
}
