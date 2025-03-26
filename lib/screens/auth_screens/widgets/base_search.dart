import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:streamfi/core/constants/assets.dart';
import 'package:streamfi/core/themes/color_scheme.dart';


class BaseSearchField extends StatefulWidget {
  final String? hintText;
  TextEditingController? textEditingController;
  final Function(String? value)? onTyping;


  BaseSearchField({
    super.key,
    this.hintText,
    this.textEditingController,
    this.onTyping,
  });

  @override
  State<BaseSearchField> createState() => _BaseSearchFieldState();
}

class _BaseSearchFieldState extends State<BaseSearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      controller: widget.textEditingController,
      onChanged: (val) => widget.onTyping!(val),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey500.withOpacity(0.18),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.textHintColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(0),
          child: SvgPicture.asset(
            AppAssets.searchIcon,
            fit: BoxFit.scaleDown,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.grey400,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
