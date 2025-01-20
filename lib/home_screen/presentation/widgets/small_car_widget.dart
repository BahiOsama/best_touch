import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/domain/models/get_services/get_services.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/screens/normal_wash.dart';

class SmallCarWidget extends StatelessWidget {
  final GetServices getServices;
  final int index;
  final String screenName;

  const SmallCarWidget({
    super.key,
    required this.getServices,
    required this.index,
    required this.screenName,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 20, left: 20).r,
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.black12)),
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            right: 12,
          ).r,
          child: ListTile(
            title: Text(
              getServices.data!.data![index].name!,
              style: AppStyles.medium16,
            ),
            subtitle: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  AnimationRoute(
                    page: BlocProvider(
                      create: (context) => HomeCubit(
                        getIt.get<HomeRepoImp>(),
                      )..getAdditions(),
                      child: BlocBuilder<HomeCubit, HomeCubitState>(
                        builder: (context, state) {
                          if (state is GetAdditionsSuccess) {
                            return NormalWash(
                              getServicesPrice: getServices
                                  .data!.data![index].price!
                                  .toString(),
                              getServicesName:
                                  getServices.data!.data![index].name!,
                              screenName: screenName,
                              getAdditions: state.getAdditions,
                              price: getServices.data!.data![index].price!
                                  .toString(),
                            );
                          } else if (state is GetAdditionsLoading) {
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
                            return const Text('Faileur  ...');
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'What does it include?'.tr(),
                style: AppStyles.medium12
                    .copyWith(color: AppColors.transperantBlack),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getServices.data!.data![index].price!.toString(),
                  style: AppStyles.semiBold14,
                ),
                Text(
                  ' ر.س',
                  style: AppStyles.semiBold14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
