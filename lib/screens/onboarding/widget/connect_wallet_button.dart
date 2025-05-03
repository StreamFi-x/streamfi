import 'package:flutter/material.dart';
import 'package:streamfi/core/constants/fonts.dart';
import 'package:streamfi/core/themes/color_scheme.dart';
import 'package:streamfi/screens/onboarding/connect%20wallet._screen.dart';

class ConnectWalletButton extends StatelessWidget {
  const ConnectWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showWalletConnectionBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white100,
          foregroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(
          'Connect Wallet',
          style: StreamfiFonts.b1(context).copyWith(
            color: AppColors.black100,
          ),
        ),
      ),
    );
  }

  void _showWalletConnectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const WalletConnectionBottomSheet();
      },
    );
  }
}
