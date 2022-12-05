import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/providers/dashboard-providers.dart';
import 'package:maple/utils/colors.dart';
import 'package:maple/widgets/maple-scaffold.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> navWidget = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.indigo,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(color: Colors.red),
    Container(
      color: Colors.black,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<DashboardProviders>().appBarColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Image.asset('assets/images/logo-maple-kecil.png'),
        ),
        leadingWidth: 108.81.w,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/search-icon.png')),
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/profile-icon.png'))
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
          context.read<DashboardProviders>().setNavIndex(index);
        },
        currentIndex: context.watch<DashboardProviders>().navIndex,
      ),
      body: navWidget[context.watch<DashboardProviders>().navIndex],
    );
  }
}