import 'package:flutter/material.dart';
import 'package:streamfi/core/constants/assets.dart';
import 'package:streamfi/core/constants/fonts.dart';
import 'package:streamfi/core/themes/color_scheme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:streamfi/screens/onboarding/widget/connect_wallet_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF1d0834),
              Color(0xFF101f41),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.graphic_eq,
                            color: AppColors.white100,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'StreamFi',
                            style: StreamfiFonts.b1(context).copyWith(
                              color: AppColors.white100,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 1),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: SvgPicture.asset(
                          AppAssets.streamfiOnb,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Catch the Game.',
                        style: StreamfiFonts.h1(context).copyWith(
                          color: AppColors.white100,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Join the Fun.',
                        style: StreamfiFonts.h1(context).copyWith(
                          color: AppColors.white100,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    const ConnectWalletButton(),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Continue as Guest',
                        style: StreamfiFonts.b2(context).copyWith(
                          color: AppColors.white100,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: StreamfiFonts.b3(context).copyWith(
                            color: AppColors.grey300,
                            fontSize: 10,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'By proceeding, I acknowledge that I have read and agreed to StreamFi\'s ',
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: StreamfiFonts.b3(context).copyWith(
                                color: AppColors.grey300,
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
                                color: AppColors.grey300,
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
