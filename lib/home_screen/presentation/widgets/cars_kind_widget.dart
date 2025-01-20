import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/domain/models/car_size/car_size.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/screens/small_car.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class CarsKindWidget extends StatelessWidget {
  final GetCarSize getCarSize;
  final int getCarSizeindex;
  final int washerid;

  const CarsKindWidget({
    super.key,
    required this.getCarSize,
    required this.getCarSizeindex,
    required this.washerid,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          AnimationRoute(
            page: BlocProvider(
              create: (context) => HomeCubit(
                getIt.get<HomeRepoImp>(),
              )..getCarsServices(
                  sizeid: getCarSize.data![getCarSizeindex].id!,
                  washer: washerid,
                ),
              child: BlocBuilder<HomeCubit, HomeCubitState>(
                builder: (context, state) {
                  if (state is GetCarServicesSuccess) {
                    return SmallCar(
                      screenName: getCarSize.data![getCarSizeindex].name!.tr(),
                      getServices: state.getServices,
                    );
                  } else if (state is GetCarServicesLoading) {
                    return Center(
                      child: LoadingAnimationWidget.flickr(
                        leftDotColor: AppColors.secondColor,
                        rightDotColor: AppColors.whiteColor,
                        size: 50,
                      ),
                    );
                  } else {
                    return const Text(
                      'Faileur ...',
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
              right: 12,
            ),
            child: ListTile(
              leading: Image.network(
                getCarSize.data![getCarSizeindex].image!,
                width: 77,
              ),
              title: Text(
                getCarSize.data![getCarSizeindex].name!.tr(),
                style: AppStyles.semiBold14,
              ),
              subtitle: Text(
                getCarSize.data![getCarSizeindex].description!,
              ),
              trailing: ConfirmOrGoBackk(
                text: 'Choose'.tr(),
                width: 65,
                height: 33,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
