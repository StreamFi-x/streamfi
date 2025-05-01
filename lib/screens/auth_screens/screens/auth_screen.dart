import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:streamfi/core/constants/assets.dart';
import 'package:streamfi/core/themes/color_scheme.dart';
import 'package:streamfi/screens/auth_screens/widgets/base_search.dart';
import 'package:streamfi/screens/widgets/button/primary_button.dart';
import 'package:streamfi/core/shared/dialogs/email_verification_dialog.dart';

import '../widgets/drawer_item.dart';
import '../widgets/recommended_item.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        leading: isTablet
            ? null
            : Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: SvgPicture.asset(AppAssets.hamburger),
                  );
                },
              ),
        title: SvgPicture.asset(AppAssets.streamFi),
        actions: [
          GestureDetector(
            onTap: () {
              // showWalletSelectionDialog(context);
              showProfileDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.purpleColor,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Connect',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      drawer: isTablet ? null : _buildDrawer(context, isTablet),
      body: isTablet
          ? Row(
              children: [
                // Permanent drawer for tablet
                SizedBox(
                  width: 280, // Standard drawer width
                  child:
                      _buildDrawer(context, isTablet, closeDrawerOnTap: false),
                ),
                // Vertical divider
                Container(
                  width: 1,
                  color: AppColors.selectedDrawer,
                ),
                // Main content
                Expanded(
                  child: Column(),
                ),
              ],
            )
          : Column(),
    );
  }

  Widget customTextField({
    required String label,
    required String hint,
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color(0xffD9D9D9))),
        SizedBox(height: 5),
        TextField(
          maxLines: isMultiline ? 3 : 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[900],
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white60),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  void showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double dialogWidth =
                constraints.maxWidth > 600 ? 500 : constraints.maxWidth * 0.9;

            return AlertDialog(
              backgroundColor: Color(0xff0F0F0F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text(
                "Complete Your Profile",
                style: TextStyle(
                    color: Color(0xff5A189A),
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              content: Container(
                width: dialogWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Set up your profile to get the best experience on StreamFi",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    customTextField(
                        label: "Display Name", hint: "Chidinma Cassandra"),
                    customTextField(
                        label: "Email Address",
                        hint: "Enter a valid email address"),
                    customTextField(
                        label: "Bio (optional)",
                        hint: "Tell your audience a bit about yourself",
                        isMultiline: true),
                  ],
                ),
              ),
              actions: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff5A189A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        Text("Confirm", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context, bool isTablet,
      {bool closeDrawerOnTap = true}) {
    return Drawer(
      backgroundColor: AppColors.primaryBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Visibility(
            visible: !isTablet,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.grey500.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(7.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: SvgPicture.asset(AppAssets.cancelIcon),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BaseSearchField(
                    hintText: 'Search here...',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DrawerItem(
            icon: AppAssets.homeIcon,
            title: 'Home',
            isSelected: _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              if (closeDrawerOnTap) Navigator.pop(context);
            },
          ),
          DrawerItem(
              icon: AppAssets.trendingIcon,
              title: 'Trending',
              isSelected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                if (closeDrawerOnTap) Navigator.pop(context);
              }),
          DrawerItem(
              icon: AppAssets.watchLaterIcon,
              title: 'Watch Later',
              isSelected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                if (closeDrawerOnTap) Navigator.pop(context);
              }),
          DrawerItem(
              icon: AppAssets.liveIcon,
              title: 'Live',
              isSelected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                if (closeDrawerOnTap) Navigator.pop(context);
              }),
          DrawerItem(
              icon: AppAssets.favouriteIcon,
              title: 'Saved Videos',
              isSelected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                if (closeDrawerOnTap) Navigator.pop(context);
              }),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.selectedDrawer,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'RECOMMENDED',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RecommendedItem(
            imageUrl: AppAssets.live,
            title: 'Zyn',
            subtitle: '24.k watching',
            onTap: () {
              // Handle tap
            },
          ),
          SizedBox(
            height: 10,
          ),
          RecommendedItem(
            imageUrl: AppAssets.live,
            title: 'monki',
            subtitle: '24.k watching',
            onTap: () {
              // Handle tap
            },
          ),
          SizedBox(
            height: 10,
          ),
          RecommendedItem(
            imageUrl: AppAssets.dummyAvi,
            title: 'monki',
            subtitle: 'Offline',
            onTap: () {
              // Handle tap
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PrimaryButton(
                onTaps: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => EmailVerificationDialog(
                      email: "user@example.com", // Replace with actual user email
                      onVerify: (code) {
                        // Handle verification logic here
                        print("Verification code: $code");
                      },
                      onResend: () {
                        // Handle resend logic here
                        print("Resend code requested");
                      },
                    ),
                  );
                },
                height: 34,
                buttonTitle: 'See more',
                colors: Colors.white.withOpacity(0.30)),
          )
        ],
      ),
    );
  }

  void showWalletSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff0F0F0F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Text(
                'Select a wallet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Securely authenticate & start streaming with full ownership over your earnings.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20),
              _walletOption(
                context,
                icon: 'assets/images/meta_mask.png',
                label: 'Metamask',
                onTap: () {},
              ),
              Divider(
                color: Colors.grey,
              ),
              _walletOption(
                context,
                icon: 'assets/images/wallet_connect.png',
                label: 'WalletConnect',
                onTap: () {},
              ),
              Divider(
                color: Colors.grey,
              ),
              _walletOption(
                context,
                icon: 'assets/images/argent.png',
                label: 'Argent',
                onTap: () {},
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _walletOption(
    BuildContext context, {
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(icon, width: 24, height: 24),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
