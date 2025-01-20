import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/normal_wash.dart';
import 'package:second_project/home_screen/presentation/screens/payment.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class ReservationConfirm extends StatefulWidget {
  const ReservationConfirm({
    super.key,
    required this.additionalServices,
    required this.freeServices,
    required this.init,
    required this.add,
    required this.all,
    required this.screenName,
    required this.getServicesName,
    required this.getServicesPrice,
  });
  final List<Map<String, dynamic>> additionalServices;
  final List<Map<String, dynamic>> freeServices;
  final double init, add, all;
  final String screenName;
  final String getServicesName;
  final String getServicesPrice;

  @override
  State<ReservationConfirm> createState() => _ReservationConfirmState();
}

class _ReservationConfirmState extends State<ReservationConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Confirm Booking".tr()),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black12)),
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    right: 12,
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          widget.screenName,
                          style: AppStyles.medium16,
                        ),
                        const Text(' _ '),
                        Text(
                          widget.getServicesName,
                          style: AppStyles.medium16,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '2 Chairs'.tr(),
                      style: AppStyles.medium12
                          .copyWith(color: AppColors.transperantBlack),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.getServicesPrice,
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppPadding.homepadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    20.verticalSpace,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  15.verticalSpace,
                  Padding(
                    padding: AppPadding.homepadding,
                    child: Text(
                      'Additional Services'.tr(),
                      style: AppStyles.medium16,
                    ),
                  ),
                  10.verticalSpace,
                  if (widget.additionalServices.isEmpty)
                    Center(child: Text('No additional services selected'.tr()))
                  else
                    Column(
                      children: widget.additionalServices.map((service) {
                        return Row(
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
                                value: service['selected'],
                                onChanged: (value) {},
                              ),
                            ),
                            Text(
                              service['name'],
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  15.verticalSpace,
                  Padding(
                    padding: AppPadding.homepadding,
                    child: Text(
                      'Free Services'.tr(),
                      style: AppStyles.medium16,
                    ),
                  ),
                  10.verticalSpace,
                  if (widget.freeServices.isEmpty)
                    Center(child: Text('No additional services selected'.tr()))
                  else
                    Column(
                      children: widget.freeServices.map((service) {
                        return Row(
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
                                value: service['selected'],
                                onChanged: (value) {},
                              ),
                            ),
                            Text(service['name']),
                          ],
                        );
                      }).toList(),
                    ),
                  20.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12))),
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
                    '${widget.init} ر.س',
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
                          '${widget.add} ر.س',
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
                            '${widget.all} ر.س',
                            style: AppStyles.medium14
                                .copyWith(color: AppColors.secondColor),
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
                Navigator.push(
                  context,
                  AnimationRoute(
                    page: Payment(
                      add: widget.add,
                      all: widget.all,
                      init: widget.init,
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
