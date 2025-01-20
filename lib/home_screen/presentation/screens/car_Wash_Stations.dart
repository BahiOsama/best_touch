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
import 'package:second_project/home_screen/presentation/widgets/car_wash_station_show_dialog.dart';
import 'package:second_project/home_screen/presentation/widgets/car_wash_station_widget.dart';

class CarWashStations extends StatefulWidget {
  const CarWashStations({super.key});

  @override
  State<CarWashStations> createState() => _CarWashStationsState();
}

String order = 'All'.tr();

class _CarWashStationsState extends State<CarWashStations> {
  ValueNotifier<String?> name = ValueNotifier("");
  String lastSelectedOption = options[0];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        getIt.get<HomeRepoImp>(),
      )..getWashers(),
      child: BlocConsumer<HomeCubit, HomeCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          if (state is GetWaherssuccess) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    title: Text("Car Wash Stations".tr()),
                    leading: Padding(
                      padding: AppPadding.appbarpadding,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(AppImages.rightArrow),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    expandedHeight: 30,
                    floating: false,
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        25.verticalSpace,
                        Padding(
                          padding: AppPadding.homepadding,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: CarWashStationShowDialog(
                                    initialSelectedOption: lastSelectedOption,
                                    onSortSelected: (String sortName) {
                                      name.value = sortName;
                                      lastSelectedOption = sortName;
                                      if (sortName == 'Highest Rated'.tr()) {
                                        homeCubit.getWashers(
                                            highRate: 1, nearest: 0);
                                      } else if (sortName ==
                                          'Nearest to You'.tr()) {
                                        homeCubit.getWashers(
                                            highRate: 0, nearest: 1);
                                      } else {
                                        homeCubit.getWashers(
                                            highRate: 0, nearest: 0);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Sort By'.tr(),
                                  style: AppStyles.medium16,
                                ),
                                5.horizontalSpace,
                                ValueListenableBuilder(
                                    valueListenable: name,
                                    builder: (context, value, child) {
                                      return Text(
                                        name.value!.isNotEmpty
                                            ? name.value!
                                            : 'All'.tr(),
                                        style: AppStyles.medium16.copyWith(
                                            color: AppColors.secondColor),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.getWashers.data!.data!.length,
                      (context, index) {
                        return CarWashStationsWidget(
                          getWashers: state.getWashers.data!.data!,
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetWaherssLoading) {
            return Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: AppColors.secondColor,
                rightDotColor: AppColors.whiteColor,
                size: 50,
              ),
            );
          } else {
            return const Text('Faileur');
          }
        },
      ),
    );
  }
}
