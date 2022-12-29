import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/authentication/views/auth-screen.dart';
import 'package:maple/features/dashboard/activty/view/activity-screen.dart';
import 'package:maple/features/dashboard/articles/view/article-screen.dart';
import 'package:maple/features/dashboard/home/views/home-screen.dart';
import 'package:maple/features/dashboard/media/views/media-screen.dart';
import 'package:maple/features/dashboard/merch/views/merch-screen.dart';
import 'package:maple/features/dashboard/providers/dashboard-providers.dart';
import 'package:maple/features/dashboard/search-view.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';

import '../profile/views/profile-screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> navWidget = [
    HomeScreen(),
    ArticleScreen(),
    MediaScreen(),
    MerchScreen(),
    ActivityScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<DashboardProviders>().appBarColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Image.asset('assets/images/logo-maple-kecil.png'),
        ),
        leadingWidth: 108.81.w,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
              },
              icon: Image.asset(
                'assets/images/search-icon.png',
                color: context.watch<DashboardProviders>().appBarColor ==
                        MapleColor.white
                    ? Colors.black
                    : Colors.white,
              )),
          IconButton(
              onPressed: () async {
                var data = await LocalStorageService.load('user');

                print(data);

                if (data['data']['username'] == 'guest') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                }
              },
              icon: Image.asset(
                'assets/images/profile-icon.png',
                color: context.watch<DashboardProviders>().appBarColor ==
                        MapleColor.white
                    ? Colors.black
                    : Colors.white,
              ))
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/maple-nav.png',
              width: 26.w,
              height: 26.h,
            ),
            activeIcon: Image.asset(
              'assets/images/maple-active-nav.png',
              width: 26.w,
              height: 26.h,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/article-nav.png',
              height: 26.h,
              width: 26.w,
            ),
            activeIcon: Image.asset(
              'assets/images/article-active-nav.png',
              height: 26.h,
              width: 26.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/media-nav.png',
              height: 26.h,
              width: 26.w,
            ),
            activeIcon: Image.asset(
              'assets/images/media-active-nav.png',
              height: 26.h,
              width: 26.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/merch-nav.png',
              height: 26.h,
              width: 26.w,
            ),
            activeIcon: Image.asset(
              'assets/images/merch-active-nav.png',
              height: 26.h,
              width: 26.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/activity-nav.png',
              height: 26.h,
              width: 26.w,
            ),
            activeIcon: Image.asset(
              'assets/images/activity-active-nav.png',
              height: 26.h,
              width: 26.w,
            ),
          ),
        ],
        activeColor: MapleColor.indigo,
        inactiveColor: MapleColor.white,
        onTap: (index) {
          context.read<DashboardProviders>().setColor(MapleColor.indigo);
          if (index == 1) {
            context.read<DashboardProviders>().setColor(MapleColor.white);
          } else if (index == 3) {
            context.read<DashboardProviders>().setColor(Colors.black);
          }

          context.read<DashboardProviders>().setType('');
          context.read<DashboardProviders>().setNavIndex(index);
        },
        currentIndex: context.watch<DashboardProviders>().navIndex,
      ),
      body: navWidget[context.watch<DashboardProviders>().navIndex],
    );
  }
}
