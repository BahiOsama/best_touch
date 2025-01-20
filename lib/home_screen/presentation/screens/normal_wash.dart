import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/domain/models/get_additions/get_additions.dart';
import 'package:second_project/home_screen/presentation/screens/reservation_confirm.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class NormalWash extends StatefulWidget {
  final String price;
  final GetAdditions getAdditions;
  final String screenName;
  final String getServicesName;
  final String getServicesPrice;

  const NormalWash({
    super.key,
    required this.price,
    required this.getAdditions,
    required this.screenName,
    required this.getServicesName,
    required this.getServicesPrice,
  });

  @override
  State<NormalWash> createState() => _NormalWashState();
}

List<bool> additionalServicesSelected = [];
List<bool> freeServicesSelected = List.generate(5, (_) => false);

class _NormalWashState extends State<NormalWash> {
  late double initialPrice;
  late double totalPrice;
  double additionalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    initialPrice = double.tryParse(widget.price) ?? 0.0;
    totalPrice = initialPrice;
    additionalServicesSelected = List.filled(
      widget.getAdditions.data!.length,
      false,
    );
    resetServices();
  }

  void resetServices() {
    additionalServicesSelected = List.filled(
      widget.getAdditions.data!.length,
      false,
    );
    freeServicesSelected = List.generate(5, (_) => false);
    updatePrice();
  }

  void updatePrice() {
    additionalPrice = 0.0;

    for (int i = 0; i < additionalServicesSelected.length; i++) {
      if (additionalServicesSelected[i]) {
        additionalPrice += widget.getAdditions.data![i].price ?? 0.0;
      }
    }

    setState(() {
      totalPrice = initialPrice + additionalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.getServicesName.tr(),
        ),
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Services Offered'.tr(),
                    style: AppStyles.medium16,
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.chexhbox,
                      ),
                      5.horizontalSpace,
                      Text(
                        'Service Number 1'.tr(),
                        style: AppStyles.regular14
                            .copyWith(color: AppColors.transperantBlack),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  10.verticalSpace,
                  Text(
                    'Additional Services'.tr(),
                    style: AppStyles.medium16,
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: additionalServicesSelected.length,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4, left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              activeColor: Colors.green,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              focusColor: AppColors.whiteColor,
                              side: const BorderSide(
                                  color: AppColors.transperantBlack),
                              value: additionalServicesSelected[index],
                              onChanged: (value) {
                                setState(() {
                                  additionalServicesSelected[index] = value!;
                                  updatePrice();
                                });
                              },
                            ),
                          ),
                          5.horizontalSpace,
                          Text(
                            widget.getAdditions.data![index].name!,
                            style: AppStyles.regular14
                                .copyWith(color: AppColors.transperantBlack),
                          ),
                        ],
                      ),
                      Text(
                        '${widget.getAdditions.data![index].price.toString()} ر.س',
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  10.verticalSpace,
                  Text(
                    'Free Services'.tr(),
                    style: AppStyles.medium16,
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4, left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              activeColor: Colors.green,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              focusColor: AppColors.whiteColor,
                              side: const BorderSide(
                                  color: AppColors.transperantBlack),
                              value: freeServicesSelected[index],
                              onChanged: (value) {
                                setState(() {
                                  freeServicesSelected[index] = value!;
                                });
                              },
                            ),
                          ),
                          5.horizontalSpace,
                          Text(
                            'Service Number 1'.tr(),
                            style: AppStyles.regular14
                                .copyWith(color: AppColors.transperantBlack),
                          ),
                        ],
                      ),
                      Text(
                        'Free'.tr(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price'.tr(),
                  ),
                  Text(
                    '$initialPrice ر.س',
                    style: AppStyles.medium14,
                  ),
                ],
              ),
            ),
            if (additionalServicesSelected.contains(true))
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add-ons'.tr(),
                        ),
                        Text(
                          '$additionalPrice ر.س',
                          style: AppStyles.medium14,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total'.tr(),
                          ),
                          Text(
                            '$totalPrice ر.س',
                            style: AppStyles.medium14.copyWith(
                              color: AppColors.secondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            20.verticalSpace,
            ConfirmOrGoBackk(
              text: 'Book'.tr(),
              onTap: () {
                List<Map<String, dynamic>> selectedAdditionalServices = [];
                List<Map<String, dynamic>> selectedFreeServices = [];
                for (int i = 0; i < additionalServicesSelected.length; i++) {
                  if (additionalServicesSelected[i]) {
                    selectedAdditionalServices.add({
                      'name': widget.getAdditions.data![i].name,
                      'selected': true,
                    });
                  }
                }

                for (int i = 0; i < freeServicesSelected.length; i++) {
                  if (freeServicesSelected[i]) {
                    selectedFreeServices.add({
                      'name': 'Service Number ${i + 1}',
                      'selected': true,
                    });
                  }
                }

                Navigator.push(
                  context,
                  AnimationRoute(
                    page: ReservationConfirm(
                      getServicesPrice: widget.getServicesPrice,
                      getServicesName: widget.getServicesName,
                      screenName: widget.screenName,
                      add: additionalPrice,
                      all: totalPrice,
                      init: initialPrice,
                      additionalServices: selectedAdditionalServices,
                      freeServices: selectedFreeServices,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
