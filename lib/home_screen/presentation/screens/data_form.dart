import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/terms_and_conditions.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  TextEditingController nameEditingController = TextEditingController();

  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController lettersEditingController = TextEditingController();
  TextEditingController numbersEditingController = TextEditingController();
  TextEditingController brandEditingController = TextEditingController();
  TextEditingController tybeEditingController = TextEditingController();

  bool isAgreed = false;
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  File? imagefile;
  String? base64String;
  List<File> imageFiles = [];

  @override
  void dispose() {
    nameEditingController.dispose();
    phoneEditingController.dispose();
    lettersEditingController.dispose();
    numbersEditingController.dispose();
    brandEditingController.dispose();
    tybeEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Data Form".tr()),
          leading: Padding(
            padding: AppPadding.appbarpadding,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                AppImages.close,
              ),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Padding(
            padding: AppPadding.appbarpadding,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: 4.r),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.aboutus,
                      ),
                      10.horizontalSpace,
                      Text(
                        'Please fill in the following details'.tr(),
                        style: AppStyles.medium14
                            .copyWith(color: AppColors.transperantBlack),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Text(
                  "Car Owner's Name".tr(),
                  style: AppStyles.medium16,
                ),
                8.verticalSpace,
                TextFieldWidget(
                  obsecureText: false,
                  textEditingController: nameEditingController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'Please Enter Valid Name';
                    } else {
                      return null;
                    }
                  },
                  hintText: "Car Owner's Name".tr(),
                  textColor: AppColors.transperantBlack,
                ),
                20.verticalSpace,
                Text(
                  "Enter phone number".tr(),
                  style: AppStyles.medium16,
                ),
                8.verticalSpace,
                TextFieldWidget(
                  keyboardType: TextInputType.number,
                  textEditingController: phoneEditingController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'Please Enter Valid Number';
                    } else {
                      return null;
                    }
                  },
                  obsecureText: false,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 12).r,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppImages.saudiFlag,
                        ),
                        SizedBox(
                          width: 8.r,
                        ),
                        const Text(
                          '+966',
                        )
                      ],
                    ),
                  ),
                  hintText: "Enter phone number".tr(),
                ),
                20.verticalSpace,
                Text(
                  "Car Plate".tr(),
                  style: AppStyles.medium16,
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: lettersEditingController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 2) {
                            return 'Please Enter Valid Letters';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Letters'.tr(),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.transperantBlack)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.r),
                    Expanded(
                      child: TextFormField(
                        controller: numbersEditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 2) {
                            return 'Please Enter Valid Numbers';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Numbers'.tr(),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.transperantBlack)),
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                Text(
                  "Car brand".tr(),
                  style: AppStyles.medium16,
                ),
                8.verticalSpace,
                TextFieldWidget(
                  obsecureText: false,
                  textEditingController: brandEditingController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'Please Enter Valid Brand';
                    } else {
                      return null;
                    }
                  },
                  hintText: "Car brand".tr(),
                  textColor: AppColors.transperantBlack,
                ),
                20.verticalSpace,
                Text(
                  "Car Type".tr(),
                  style: AppStyles.medium16,
                ),
                8.verticalSpace,
                TextFieldWidget(
                  obsecureText: false,
                  textEditingController: tybeEditingController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return 'Please Enter Valid Type';
                    } else {
                      return null;
                    }
                  },
                  hintText: "Car Type".tr(),
                  textColor: AppColors.transperantBlack,
                ),
                25.verticalSpace,
                Text(
                  "Please take some pictures of the car".tr(),
                  style: AppStyles.medium16,
                ),
                10.verticalSpace,
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'Please Choose An Option',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);

                                      pickedImageWithCamera();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Camera',
                                          style: AppStyles.regular16.copyWith(
                                              color: AppColors.secondColor),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.camera,
                                          color: AppColors.secondColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);

                                      pickedImageWithGallery();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Gallery',
                                          style: AppStyles.regular16.copyWith(
                                              color: AppColors.secondColor),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.browse_gallery,
                                          color: AppColors.secondColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        AppImages.uploadPhoto,
                      ),
                    ),
                    ...imageFiles.map((file) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          file,
                          width: 170,
                          height: 125,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  ],
                ),
                10.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.green,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusColor: AppColors.whiteColor,
                      side: const BorderSide(color: AppColors.transperantBlack),
                      value: isAgreed,
                      onChanged: (value) {
                        setState(() {
                          isAgreed = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please note that clicking this will accept the'.tr(),
                          style: AppStyles.medium16
                              .copyWith(color: AppColors.transperantBlack),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                AnimationRoute(
                                    page: const TermsAndConditions()));
                          },
                          child: Text(
                            'Terms and Conditions'.tr(),
                            style: AppStyles.medium14
                                .copyWith(color: AppColors.secondColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                30.verticalSpace,
                ConfirmOrGoBackk(
                  text: 'Pay'.tr(),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (!isAgreed) {
                        Fluttertoast.showToast(
                          msg:
                              'You must agree to the Terms and Conditions to proceed'
                                  .tr(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0.r,
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pop(context);

                              nameEditingController.clear();
                              phoneEditingController.clear();
                              lettersEditingController.clear();
                              numbersEditingController.clear();
                              brandEditingController.clear();
                              tybeEditingController.clear();

                              setState(() {
                                isAgreed = false;
                                autovalidateMode = AutovalidateMode.disabled;
                              });
                            });

                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Your request has been successfully sent. Please wait for a response'
                                        .tr(),
                                    style: AppStyles.semiBold24,
                                  ),
                                  Image.asset(AppImages.success),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickedImageWithCamera() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          imageFiles.add(File(pickedFile.path));
        });

        var imageBytes = await imagefile!.readAsBytes();
        base64String = base64Encode(imageBytes);
      } else {
        base64String ??= '';
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error while picking image: $e');
    }
  }

  void pickedImageWithGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          imagefile = File(pickedFile.path);
        });

        var imageBytes = await imagefile!.readAsBytes();
        base64String = base64Encode(imageBytes);
      } else {
        base64String ??= '';
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error while picking image: $e');
    }
  }
}
