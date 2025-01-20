import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/home_screen/domain/models/get_services/get_services.dart';
import 'package:second_project/home_screen/presentation/widgets/small_car_widget.dart';

class SmallCar extends StatelessWidget {
  final String screenName;

  final GetServices getServices;
  const SmallCar(
      {super.key, required this.getServices, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          screenName.tr(),
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
      body: ListView.builder(
        itemCount: getServices.data!.data!.length,
        itemBuilder: (context, index) => SmallCarWidget(
          screenName: screenName,
          index: index,
          getServices: getServices,
        ),
      ),
    );
  }
}
