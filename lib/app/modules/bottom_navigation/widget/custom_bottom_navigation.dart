import 'package:flutter/material.dart';
import 'package:library_resource_management/app/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:library_resource_management/app/modules/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_route_names.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<BottomNavigationProvider>(context);
    final currentIndex = navigationProvider.currentIndex;

    return Consumer<ProfileController>(
      builder: (context, _profileController,_) {
        return BottomNavigationBar(
          // unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blueAccent,
          currentIndex: currentIndex,
          onTap: (int newIndex) {
            navigationProvider.updateIndex(newIndex);
            if(newIndex == 0){
              if(_profileController.role == 'Admin'){
                GoRouter.of(context).pushNamed(AppRouteName.adminDashboardRouteName);
              }else{
                // GoRouter.of(context).pushNamed(AppRouteName.adminDashboardRouteName);
                GoRouter.of(context).pushNamed(AppRouteName.studentDashboardRouteName);
;              }
            }
            if (newIndex == 1) {
              GoRouter.of(context).pushNamed(AppRouteName.categoryRouteName);
            }
            if (newIndex == 2) {
              if(_profileController.role == 'Admin'){
                GoRouter.of(context).pushNamed(AppRouteName.borrowRequestListRouteName);
              }else{
                // GoRouter.of(context).pushNamed(AppRouteName.adminDashboardRouteName);
                GoRouter.of(context).pushNamed(AppRouteName.myBorrowRequestRouteName);
                ;              }
            }
            if (newIndex == 3) {
              GoRouter.of(context).pushNamed(AppRouteName.userProfileRouteName);
            }
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Browse',
              icon: Icon(Icons.grid_view_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Requests',
              icon: Icon(Icons.menu),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
        );
      }
    );
  }
}
