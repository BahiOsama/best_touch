import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/screens/home_screen.dart';
import 'package:second_project/home_screen/presentation/widgets/car_wash_station_widget.dart';

class ExploreCarWashStationWidget extends StatelessWidget {
  const ExploreCarWashStationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        getIt.get<HomeRepoImp>(),
      )..getWashers(),
      child: BlocConsumer<HomeCubit, HomeCubitState>(
        listener: (context, state) {
          if (state is GetWaherssuccess) {
            getWashers.addAll(state.getWashers.data!.data!);
          }
        },
        builder: (context, state) {
          if (state is GetWaherssuccess) {
            return ListView.builder(
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: getWashers.length,
              itemBuilder: (context, index) => CarWashStationsWidget(
                index: index,
                getWashers: getWashers,
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
