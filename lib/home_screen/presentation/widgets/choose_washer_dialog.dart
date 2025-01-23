import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';

class ChooseWasherDialog extends StatefulWidget {
  final ValueChanged<String> onCarWashSelected;

  const ChooseWasherDialog({
    super.key,
    required this.onCarWashSelected,
  });

  @override
  State<ChooseWasherDialog> createState() => _ChooseWasherDialogState();
}

class _ChooseWasherDialogState extends State<ChooseWasherDialog> {
  List<String> options = [
    'كلين',
    'كلين أوف',
    'تيست',
    'بيست تاتش',
    'المحمدى',
    'نو كلين',
  ];
  late int currentOption;
  ValueNotifier<String?> nameWaher = ValueNotifier(null);
  @override
  void initState() {
    currentOption = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 220.r,
        padding: const EdgeInsets.only(top: 7, bottom: 7, right: 12).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6).r,
          border: Border.all(
            color: Colors.black26,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: nameWaher,
          builder: (BuildContext context, String? value, Widget? child) => Text(
            nameWaher.value ?? 'Choose a Car Wash (Mandatory)'.tr(),
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context,
                      void Function(void Function()) setState) =>
                  AlertDialog(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Choose a Car Wash').tr(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppImages.close,
                        ),
                      ),
                    ],
                  ),
                ),
                content: SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onCarWashSelected(options[index]);
                          setState(() {
                            currentOption = index;
                            nameWaher.value = options[currentOption];
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.3.r,
                                child: Radio(
                                  value: index,
                                  groupValue: currentOption,
                                  onChanged: (value) {
                                    Navigator.pop(context);
                                    widget.onCarWashSelected(options[index]);
                                    setState(() {
                                      currentOption = value!;
                                      nameWaher.value = options[currentOption];
                                    });
                                  },
                                ),
                              ),
                              Image.asset(
                                AppImages.smallPhotoForHomeScreennn,
                              ),
                              SizedBox(
                                width: 8.r,
                              ),
                              Text(
                                options[index],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
