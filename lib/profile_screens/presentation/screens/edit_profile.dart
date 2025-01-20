import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/profile_screens/domain/models/get_profile_details.dart';
import 'package:second_project/profile_screens/presentation/cubit/profile_cubit.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.getProfileDetails});
  final GetProfileDetails getProfileDetails;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  File? imagefile;
  String? base64String;

  @override
  void initState() {
    super.initState();
    nameEditingController =
        TextEditingController(text: widget.getProfileDetails.name ?? '');
    emailEditingController =
        TextEditingController(text: widget.getProfileDetails.email ?? '');
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is EditProfileAndChangePasswordsuccess) {
          Navigator.pop(context);
        }
        if (state is EditProfileAndChangePasswordFaileur) {
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
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Edit Profile".tr()),
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
            padding: AppPadding.homepadding,
            child: ListView(
              children: [
                30.verticalSpace,
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: imagefile == null
                            ? Image.network(
                                widget.getProfileDetails.avatar ?? "",
                                width: 77,
                                height: 77,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                fit: BoxFit.cover,
                                imagefile!,
                                width: 77,
                                height: 77,
                              ),
                      ),
                      Positioned(
                        bottom: -15,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              style: AppStyles.regular16
                                                  .copyWith(
                                                      color: AppColors
                                                          .secondColor),
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
                                              style: AppStyles.regular16
                                                  .copyWith(
                                                      color: AppColors
                                                          .secondColor),
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
                            AppImages.camera,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,
                Text(
                  "Username".tr(),
                  style: AppStyles.regular14,
                ),
                3.verticalSpace,
                TextFieldWidget(
                  obsecureText: false,
                  textEditingController: nameEditingController,
                  prefixIcon: Image.asset(AppImages.profile),
                  hintText: "Username".tr(),
                ),
                15.verticalSpace,
                Text(
                  "Email".tr(),
                  style: AppStyles.regular14,
                ),
                3.verticalSpace,
                TextFieldWidget(
                  obsecureText: false,
                  textEditingController: emailEditingController,
                  prefixIcon: Image.asset(
                    AppImages.gmail,
                    color: Colors.black26,
                  ),
                  hintText: "Email".tr(),
                ),
                35.verticalSpace,
                ConfirmOrGoBackk(
                  text: 'Edit'.tr(),
                  onTap: () {
                    context.read<ProfileCubit>().editProfileAndChangePassword(
                          name: nameEditingController.text,
                          email: emailEditingController.text,
                          avatar: base64String,
                        );
                  },
                ),
                30.verticalSpace,
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.delete,
                      ),
                      5.horizontalSpace,
                      Text(
                        "Delete Account".tr(),
                        style: AppStyles.regular14
                            .copyWith(color: AppColors.redColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
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
          imagefile = File(pickedFile.path);
        });

        var imageBytes = await imagefile!.readAsBytes();
        base64String = base64Encode(imageBytes);

        // debugPrint('Base64 String: $base64String');
      } else {
        base64String ??= '';
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error while picking image: $e');
    }
  }

////

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

        // debugPrint('Base64 String: $base64String');
      } else {
        base64String ??= '';
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error while picking image: $e');
    }
  }
}
