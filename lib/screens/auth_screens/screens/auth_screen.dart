import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:streamfi/core/constants/assets.dart';
import 'package:streamfi/core/themes/color_scheme.dart';
import 'package:streamfi/screens/auth_screens/widgets/base_search.dart';
import 'package:streamfi/screens/widgets/button/primary_button.dart';

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
                  onTap: (){
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(
                      AppAssets.hamburger
                  ),
                );
              },
            ),
        title: SvgPicture.asset(
            AppAssets.streamFi
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.purpleColor,
                  borderRadius: BorderRadius.circular(7.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Connect',
                  style: TextStyle(
                      color: AppColors.white
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
                child: _buildDrawer(context, isTablet, closeDrawerOnTap: false),
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

  Widget _buildDrawer(BuildContext context, bool isTablet, {bool closeDrawerOnTap = true}) {
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
                            borderRadius: BorderRadius.circular(7.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: SvgPicture.asset(
                              AppAssets.cancelIcon
                          ),
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
            }
          ),
          DrawerItem(
            icon: AppAssets.watchLaterIcon,
            title: 'Watch Later',
            isSelected: _selectedIndex == 2,
            onTap: () {
              _onItemTapped(2);
              if (closeDrawerOnTap) Navigator.pop(context);
            }
          ),
          DrawerItem(
            icon: AppAssets.liveIcon,
            title: 'Live',
            isSelected: _selectedIndex == 3,
            onTap: () {
              _onItemTapped(3);
              if (closeDrawerOnTap) Navigator.pop(context);
            }
          ),
          DrawerItem(
            icon: AppAssets.favouriteIcon,
            title: 'Saved Videos',
            isSelected: _selectedIndex == 4,
            onTap: () {
              _onItemTapped(4);
              if (closeDrawerOnTap) Navigator.pop(context);
            }
          ),
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
            child: Text('RECOMMENDED',
              style: TextStyle(
                  color: Colors.white
              ),),
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
                onTaps: (){},
                height: 34,
                buttonTitle: 'See more',
                colors: Colors.white.withOpacity(0.30)
            ),
          )
        ],
      ),
    );
  }
}
