import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/home_screen/domain/models/washer_details/washer_details.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/widgets/cars_kind_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowModalBottomSheetWidget extends StatefulWidget {
  final GetWasherDetails getWasherDetails;
  final int getWashersid; //

  const ShowModalBottomSheetWidget({
    super.key,
    required this.getWasherDetails,
    required this.getWashersid,
  });

  @override
  State<ShowModalBottomSheetWidget> createState() =>
      _ShowModalBottomSheetWidgetState();
}

final CarouselSliderController _carouselController = CarouselSliderController();
int _currentPage = 0;

class _ShowModalBottomSheetWidgetState
    extends State<ShowModalBottomSheetWidget> {
  final double latitude = 37.7749; // Example: San Francisco
  final double longitude = -122.4194;

  Future<void> _openGoogleMap() async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -120.r,
          left: 0,
          right: 0,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount:
                  (widget.getWasherDetails.data?.banners?.isNotEmpty ?? false)
                      ? widget.getWasherDetails.data!.banners!.length
                      : 1,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) {
                final imageUrl =
                    (widget.getWasherDetails.data?.banners?.isNotEmpty ?? false)
                        ? widget.getWasherDetails.data!.banners![itemIndex]
                        : 'https://picsum.photos/600/400';

                return Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                );
              },
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.3,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),
        Positioned(
          top: -80.r,
          right: 25,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppImages.rightArrow,
            ),
          ),
        ),
        Positioned(
          top: 110.r,
          left: MediaQuery.of(context).size.width * 0.5 -
              (_currentPage > 0 ? (_currentPage * 10) : 10),
          child: DotsIndicator(
            decorator: DotsDecorator(
              size: Size(13.0.r, 13.0.r),
              activeSize: Size(14.0.r, 14.0.r),
              activeColor: Colors.yellow,
            ),
            dotsCount: 1,
            position: _currentPage.toInt(),
            onTap: (position) {
              setState(() {
                _currentPage = position.toInt();
                _carouselController.animateToPage(_currentPage);
              });
            },
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.whiteColor),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 22,
              right: 20,
              left: 15,
            ).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  isThreeLine: true,
                  leading: Image.asset(AppImages.smallPhotoForHomeScreenn),
                  title: Text(
                    widget.getWasherDetails.data!.name!.tr(),
                    style: AppStyles.bold20,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '10 Kilometers Away'.tr(),
                        style: AppStyles.regular14,
                      ),
                      Text(
                        'Nearest Branches to Your Current Location'.tr(),
                        style: AppStyles.regular14.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                Text(
                  widget.getWasherDetails.data!.description!,
                  style:
                      AppStyles.regular14.copyWith(color: AppColors.mainColor),
                ),
                15.verticalSpace,
                Text(
                  "Cars Kind".tr(),
                  style: AppStyles.medium16,
                ),
                15.verticalSpace,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => BlocProvider(
                    create: (context) => HomeCubit(
                      getIt.get<HomeRepoImp>(),
                    )..getCarsSizes(),
                    child: BlocBuilder<HomeCubit, HomeCubitState>(
                      builder: (context, state) {
                        if (state is GetCarSizeSuccess) {
                          return CarsKindWidget(
                            washerid: widget.getWashersid,
                            getCarSize: state.getCarSize,
                            getCarSizeindex: index,
                          );
                        } else if (state is GetCarSizeLoading) {
                          return Center(
                            child: LoadingAnimationWidget.waveDots(
                              color: AppColors.secondColor,
                              size: 50.r,
                            ),
                          );
                        } else {
                          return const Text('Faileur');
                        }
                      },
                    ),
                  ),
                ),
                35.verticalSpace,
              ],
            ),
          ),
        ),
        Positioned(
          left: 40.r,
          top: MediaQuery.of(context).size.height * 0.155,
          child: GestureDetector(
            onTap: () {
              _openGoogleMap;
            },
            child: Image.asset(
              AppImages.openMapButton,
            ),
          ),
        ),
      ],
    );
  }
}
