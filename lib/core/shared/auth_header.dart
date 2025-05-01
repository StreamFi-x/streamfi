import 'package:flutter/material.dart';
import 'package:streamfi/core/constants/fonts.dart';
import 'package:streamfi/core/themes/color_scheme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: StreamfiFonts.h2(context).copyWith(
            fontSize: 26,
          ),
        ),
        Text(
          subtitle,
          style: StreamfiFonts.b3(context).copyWith(
            color: AppColors.grey100,
          ),
        ),
      ],
    );
  }
}
