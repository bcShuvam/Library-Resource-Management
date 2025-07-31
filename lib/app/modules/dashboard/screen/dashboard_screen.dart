import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/bottom_navigation/widget/custom_bottom_navigation.dart';
import 'package:library_resource_management/app/modules/login/controller/auth_controller.dart';
import 'package:library_resource_management/app/utils/snackbar_utils.dart';
import 'package:library_resource_management/routes/app_route_names.dart';
import 'package:library_resource_management/widgets/container/custom_container.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/appbar/custom_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: SafeArea(child: _body()),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        tabName: "Dashboard",
        applyShadow: true,
        size: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _body() {
    return Consumer<AuthController>(
      builder: (context, authController, _) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomContainer(
                verticalPad: 4,
                horizontalMargin: 0,
                width: 1,
                borderRadius: 0,
                applyShadow: true,
                // color: Theme.of(context).brightness == Brightness.dark
                //     ? const Color(0xFF1E1E1E)
                //     : Color(0xffE8F0FE),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              'Welcome, ${authController.fullName.split(' ')[0]}',
                          // text:
                          //     'Welcome, Muskan',
                          isSubHeading: true,
                        ),
                        CustomText(
                          text:
                              'Student ID: ${authController.email.split('@')[0]}',
                          // text:
                          //     'Student ID: np02cs1242323',
                          isSubContent: true,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(text: 'Resources', isSubHeading: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    resourceCard(icon: Icons.directions_run ,category: 'Sports Equipment', quantity: 20),
                    resourceCard(icon: Icons.edit ,category: 'Stationary', quantity: 156),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    resourceCard(icon: Icons.menu_book_outlined ,category: 'Study Materials', quantity: 20),
                    resourceCard(icon: Icons.grid_view_outlined ,category: 'More Categories', quantity: 156),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(text: 'Recent Requests', isSubHeading: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: (){
                      SnackBarUtils.showErrorSnackbar(context, message: 'Request already exists.');
                    },child: recentRequestCard(date: 'Today', title: 'Basketball', status: 'Approved')),
                    InkWell(
                        onTap: (){
                          SnackBarUtils.showSuccessSnackbar(context, message: 'Successfully borrowed the item. Hello world!');
                        },
                        child: recentRequestCard(date: 'Yesterday', title: 'Notebook', status: 'Pending')),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget resourceCard({
    IconData? icon,
    required String category,
    required int quantity,
    String? imageUrl,
  }) {
    return CustomContainer(
      applyShadow: true,
      width: 0.44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon ?? Icons.person, color: Colors.black),
          ),
          SizedBox(height: 12),
          CustomText(text: category, isContent: true),
          SizedBox(height: 4),
          CustomText(text: '$quantity items', isSubContent: true),
        ],
      ),
    );
  }

  Widget recentRequestCard({
    required String date,
    required String title,
    required String status,
  }) {
    return CustomContainer(
      applyShadow: true,
      width: 0.44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 20,),
              const SizedBox(width: 8,),
              CustomText(text: date, isSubContent: true),
            ],
          ),
          SizedBox(height: 8),
          CustomText(text: title, isContent: true),
          SizedBox(height: 8),
          CustomText(text: status, isSubContent: true),
        ],
      ),
    );
  }
}
