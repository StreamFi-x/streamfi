import 'package:flutter/material.dart';
import 'package:streamfi/core/constants/fonts.dart';
import 'package:streamfi/core/themes/color_scheme.dart';

class WalletConnectionBottomSheet extends StatelessWidget {
  const WalletConnectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 24 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF1d1e22),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Connect wallet',
                style: StreamfiFonts.b1(context).copyWith(
                  color: AppColors.white100,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.grey300,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Authenticate using your preferred wallet to access dApp features',
            style: StreamfiFonts.b3(context).copyWith(
              color: AppColors.grey300,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF26272b),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWalletOption(
                      context,
                      icon: 'assets/icons/metamask.png',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    _buildWalletOption(
                      context,
                      icon: 'assets/icons/avalanche.png',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    _buildWalletOption(
                      context,
                      icon: 'assets/icons/okx.png',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: StreamfiFonts.b3(context).copyWith(
                      color: AppColors.grey300,
                      fontSize: 10,
                    ),
                    children: [
                      const TextSpan(
                        text: 'By continuing, you agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: StreamfiFonts.b3(context).copyWith(
                          color: AppColors.white100,
                          fontSize: 10,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: StreamfiFonts.b3(context).copyWith(
                          color: AppColors.white100,
                          fontSize: 10,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletOption(
    BuildContext context, {
    required String icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF1d1e22),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            icon,
            width: 36,
            height: 36,
          ),
        ),
      ),
    );
  }
}
