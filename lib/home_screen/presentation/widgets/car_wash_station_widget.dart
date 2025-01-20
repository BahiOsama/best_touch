import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/home_screen/domain/models/get_washers/datum.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/widgets/show_modal_bottom_sheet_widget.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class CarWashStationsWidget extends StatelessWidget {
  final List<Datum> getWashers;
  final int index;
  const CarWashStationsWidget({
    super.key,
    required this.getWashers,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return BlocProvider(
              create: (context) => HomeCubit(
                getIt.get<HomeRepoImp>(),
              )..getWasherDetails(id: getWashers[index].id!),
              child: BlocConsumer<HomeCubit, HomeCubitState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetWasherDetailsLSuccess) {
                    return ShowModalBottomSheetWidget(
                      getWashersid: getWashers[index].id!,
                      getWasherDetails: state.getWasherDetails,
                    );
                  } else if (state is GetWasherDetailsLoading) {
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
          },
        );
      },
      child: Padding(
        padding: AppPadding.homepadding,
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, right: 12, left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  getWashers[index].image ?? AppImages.smallPhotoForHomeScreen,
                  height: 70,
                  width: 70,
                ),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getWashers[index].name!),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppImages.star),
                              4.horizontalSpace,
                              Text(
                                getWashers[index].rate!.toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(AppImages.colorLocation),
                              4.horizontalSpace,
                              Text(getWashers[index].distance.toString().tr()),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConfirmOrGoBackk(
                    text: 'Book'.tr(),
                    width: 60,
                    height: 33,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
