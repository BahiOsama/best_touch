import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/domain/models/get_washers/datum.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/home_screen/presentation/cubit/cubit/home_cubit.dart';
import 'package:second_project/home_screen/presentation/screens/car_Wash_Stations.dart';
import 'package:second_project/home_screen/presentation/widgets/carousal_slider_container_widget.dart';
import 'package:second_project/home_screen/presentation/widgets/explore_car_wash_station_widget.dart';
import 'package:second_project/home_screen/presentation/widgets/home_screen_appbar_widget.dart';
import 'package:second_project/home_screen/presentation/widgets/loyality_and_packages_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final CarouselSliderController _carouselController = CarouselSliderController();

int _currentPage = 0;
late ScrollController scrollController;
var nextPage = 2;
var isLoading = false;
List<Datum> getWashers = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() async {
    if (scrollController.position.pixels >=
        0.5 * scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        isLoading = true;
        await context.read<HomeCubit>().getWashers(
              page: nextPage++,
            );
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HomeScreenAppBarWidget(),
          20.verticalSpace,
          BlocProvider(
            create: (context) => HomeCubit(
              getIt.get<HomeRepoImp>(),
            )..getBanners(),
            child: BlocBuilder<HomeCubit, HomeCubitState>(
              builder: (context, state) {
                if (state is GetBannersSuccess) {
                  return Stack(
                    children: [
                      CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: state.getBanners.data!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          String? title =
                              state.getBanners.data![itemIndex].title;
                          String? description =
                              state.getBanners.data![itemIndex].description;
                          String? image =
                              state.getBanners.data![itemIndex].image!;
                          return CarousalSliderContainerWidget(
                              title: title,
                              description: description,
                              image: image);
                        },
                        options: CarouselOptions(
                          height: 140,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 170,
                        child: DotsIndicator(
                          decorator: const DotsDecorator(
                            activeColor: Colors.yellow,
                          ),
                          dotsCount: state.getBanners.data!.length,
                          position: _currentPage.toInt(),
                          onTap: (position) {
                            setState(() {
                              _currentPage = position.toInt();
                              _carouselController.animateToPage(_currentPage);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is GetBannersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('Faileur');
                }
              },
            ),
          ),
          30.verticalSpace,
          const LoyalityAndPackagesWidget(),
          20.verticalSpace,
          Padding(
            padding: AppPadding.homepadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Car Wash Stations'.tr(),
                  style: AppStyles.medium18,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      AnimationRoute(
                        page: const CarWashStations(),
                      ),
                    );
                  },
                  child: Text(
                    'Show All'.tr(),
                    style: AppStyles.regular12
                        .copyWith(color: AppColors.transperantBlack),
                  ),
                )
              ],
            ),
          ),
          15.verticalSpace,
          const ExploreCarWashStationWidget(),
        ],
      ),
    );
  }
}
