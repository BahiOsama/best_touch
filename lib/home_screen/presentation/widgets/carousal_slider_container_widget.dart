import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:second_project/helper/app_colors.dart';

class CarousalSliderContainerWidget extends StatelessWidget {
  const CarousalSliderContainerWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String? title;
  final String? description;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondColor.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                '$title   $description'.tr(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    image: NetworkImage(
                      image ?? 'https://i.pravatar.cc/150?img=3',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
