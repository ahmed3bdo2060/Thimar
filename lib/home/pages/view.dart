import 'package:app/core/design/app_image.dart';
import 'package:app/core/logic/app_theme.dart';
import 'package:app/home/pages/account/view.dart';
import 'package:app/home/pages/favorite/view.dart';
import 'package:app/home/pages/notifications/view.dart';
import 'package:app/home/pages/orders/view.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home/products.dart';

class HomeViewNav extends StatefulWidget {
  const HomeViewNav({super.key});

  @override
  State<HomeViewNav> createState() => _HomeViewState();
}
List list = [

];
class _HomeViewState extends State<HomeViewNav> {
  final _pageController = PageController(initialPage: 1);
  final icons = [
    "assets/svg/my_orders.svg",
    "assets/svg/notifications.svg",
    "assets/svg/home (1).svg",
    "assets/svg/favorites.svg",
    "assets/svg/my_account.svg"
  ];
  final titles = ["طلباتي", "الإشعارات", "الرئيسية", "المفضلة", "حسابي"];
  int currentPage = 2;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Theme(
          data: ThemeData().copyWith(useMaterial3: false),
          child: FloatingActionButton(
            backgroundColor: AppTheme.primary,
            onPressed: () {
              _pageController.jumpToPage(2);
            },
            child: AppImage(icons[2]),
          ),
        ),
      bottomNavigationBar:  BottomAppBar(
        color: AppTheme.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          children: List.generate(
            5,
                (index) => index == 2
                ? Spacer()
                : Expanded(
              child: GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(index);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImage(
                        icons[index],
                        color: currentPage == index ? Colors.white : Colors.grey[400],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: currentPage == index ? Colors.white : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    body:
    PageView(
    controller: _pageController,
      onPageChanged: (value) {
        currentPage = value;
        setState(() {});
      },
      children:[
        MyOrdersPage(),
        NotificationPage(),
        ProductsView(),
        FavoritePage(),
        AccountPage()
      ],
    )
      );
  }
}
