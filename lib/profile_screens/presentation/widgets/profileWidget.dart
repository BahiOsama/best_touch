import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/profile_screens/presentation/screens/edit_profile.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is GetProfileDataFaileur) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.err.toString()),
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is GetProfileDataSuccess) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                AnimationRoute(
                  page: BlocProvider.value(
                    value: BlocProvider.of<ProfileCubit>(context),
                    child: EditProfile(
                      getProfileDetails: state.getProfileDetails,
                    ),
                  ),
                ),
              );
            },
            child: Card(
              color: AppColors.whiteColor,
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12).r,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4).r,
                ),
                child: ListTile(
                  title: Text(state.getProfileDetails.name ?? ''),
                  subtitle: Row(
                    children: [
                      Image.asset(AppImages.location),
                      8.horizontalSpace,
                      Flexible(
                        child: Text(
                          state.getProfileDetails.location ?? '',
                        ),
                      ),
                    ],
                  ),
                  leading: Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24).r,
                      image: DecorationImage(
                        image: NetworkImage(
                          state.getProfileDetails.avatar!,
                        ),
                      ),
                    ),
                  ),
                  trailing: ConfirmOrGoBackk(
                    text: 'Edit'.tr(),
                    width: 75.r,
                    height: 30.r,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
