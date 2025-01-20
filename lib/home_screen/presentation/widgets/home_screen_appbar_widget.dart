import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/notifications.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/profile_screens/presentation/screens/account.dart';

class HomeScreenAppBarWidget extends StatelessWidget {
  const HomeScreenAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileDataSuccess) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                AnimationRoute(
                  page: const Account(),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  state.getProfileDetails.avatar ??
                      'https://i.pravatar.cc/150?img=3',
                ),
                backgroundColor: Colors.grey[200],
              ),
              title: Text(
                state.getProfileDetails.name ?? '',
                style: AppStyles.regular14,
              ),
              subtitle: Text(
                state.getProfileDetails.location ?? 'No Location ...',
                style: AppStyles.regular12
                    .copyWith(color: AppColors.transperantBlack),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    AnimationRoute(
                      page: const Notifications(),
                    ),
                  );
                },
                child: Image.asset(
                  AppImages.notificatiiions,
                ),
              ),
            ),
          );
        } else if (state is GetProfileDataLoading) {
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
    );
  }
}
