import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/routes/app_route_names.dart';
import 'package:library_resource_management/widgets/buttons/custom_elevated_button.dart';
import 'package:library_resource_management/widgets/container/custom_container.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation/widget/custom_bottom_navigation.dart';
import '../login/controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: body(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget body() {
    return SafeArea(
      child: Consumer<AuthController>(
        builder: (context, authProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Profile Screen',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      child: Icon(Icons.person, size: 36),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: authProvider.fullName,isContent: true,),
                        CustomText(
                          text: 'ID: ${authProvider.email.split('@')[0]}', isSubContent: true,
                        ),
                        CustomText(text: authProvider.email, isSubContent: true,),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.all(16),
                child: CustomText(
                  text: 'Currently Borrowed',
                  isSubHeading: true,
                ),
              ),
              borrowedCard(
                title: 'Football',
                dueDate: 'July 20, 2025',
                status: 'Pending Return',
              ),
              const SizedBox(height: 16),
              borrowedCard(
                title: 'Book',
                dueDate: 'July 16, 2025',
                status: 'Pending Return',
                imageUrl:
                    'https://cdn.pixabay.com/photo/2015/11/19/21/10/glasses-1052010_640.jpg',
              ),
              // const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomElevatedButton(
                  onPressed: () {
                    debugPrint('Logout button pressed');
                    authProvider.handleLogout(context);
                  },
                  backgroundColor: Colors.transparent,
                  borderColor: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white : Colors.black),
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, size: 24, color: Colors.red),
                      const SizedBox(width: 8),
                      CustomText(
                        text: 'Logout',
                        isSubHeading: true,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget borrowedCard({
    required String title,
    required String dueDate,
    required String status,
    String imageUrl =
        'https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg?cs=srgb&dl=pexels-pixabay-47730.jpg&fm=jpg',
  }) {
    return SizedBox(
      height: 125,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomContainer(
            horizontalMargin: 0,
            verticalMargin: 0,
            horizontalPad: 8,
            verticalPad: 8,
            applyShadow: true,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 108,
                    width: 160,
                    child: Image.network(imageUrl, fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: title, isContent: true),
                    // const SizedBox(height: 4,),
                    CustomText(text: dueDate, isSubContent: true),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: ColoredBox(
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: CustomText(text: status, isSmallText: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
