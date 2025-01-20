import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.textEditingController,
    this.borderSide,
    this.prefixIcon,
    this.validator,
    this.textColor,
    this.containerColor,
    this.formkey,
    this.autovalidateMode,
    this.suffixIcon,
    this.visibleIcon,
    this.enabled,
    this.obsecureText,
    this.maxlines,
  });
  final String hintText;
  final bool? visibleIcon, enabled;

  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderSide;
  final String? Function(String?)? validator;
  final Color? textColor, containerColor;
  final Key? formkey;
  final AutovalidateMode? autovalidateMode;
  final bool? obsecureText;
  final int? maxlines;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

bool visible = true;
bool obsecure = true;

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxlines ?? 1,
      enabled: widget.enabled,
      obscureText: widget.obsecureText ?? obsecure,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      key: widget.formkey,
      controller: widget.textEditingController,
      textInputAction: TextInputAction.next,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: Visibility(
            visible: widget.visibleIcon ?? false,
            child: InkWell(
                onTap: () {
                  setState(() {
                    visible = !visible;
                    obsecure = !obsecure;
                  });
                },
                child: Icon(
                  visible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black26,
                ))),
        fillColor: widget.containerColor ?? Colors.white,
        hintText: widget.hintText,
        hintStyle: AppStyles.regular12.copyWith(
          color: widget.textColor,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderSide ?? Colors.black26),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.secondColor),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        filled: true,
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.redColor)),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
