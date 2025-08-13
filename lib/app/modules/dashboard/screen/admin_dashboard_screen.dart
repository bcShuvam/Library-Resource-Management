import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/dashboard/controller/admin_controller.dart';
import 'package:library_resource_management/routes/app_route_names.dart';
import 'package:library_resource_management/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/container/custom_container.dart';
import '../../../../widgets/texts/custom_text.dart';
import '../../../utils/secure_storage_utils.dart';
import '../../bottom_navigation/widget/custom_bottom_navigation.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // late AdminController adminController;
  // late ProfileController profileController;
  // late CategoryController categoryController;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      Provider.of<AdminController>(context, listen: false).fetchAdminDashboard();
      Provider.of<AdminController>(context, listen: false).fetchAdmin(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _body() {
    return Consumer<AdminController>(
      builder: (context, adminController, _) {
        return
          // profileController.isLoading ?
          RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 300));
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                adminController.fetchAdminDashboard();
                adminController.fetchAdmin(context);
              });
            },
            child: adminController.isLoading ? Center(child: CircularProgressIndicator(),) : SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      verticalPad: 4,
                      horizontalMargin: 0,
                      width: 1,
                      borderRadius: 0,
                      applyShadow: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Admin Dashboard',
                                // text:
                                //     'Welcome, Muskan',
                                isSubHeading: true,
                              ),
                              CustomText(
                                text:
                                    'Welcome back, ${adminController.profileController.fullName.split(' ')[0]}',
                                // text:
                                //     'Student ID: np02cs1242323',
                                isSubContent: true,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              SecureStorageResponse token =
                                  await SecureStorageUtils.readFSS(
                                    SecureStorageUtils.token,
                                  );
                              debugPrint('Token: ${token.value}');
                            },
                            child: Icon(Icons.notifications_none_outlined),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    QuickAnalysisCardPair(
                      QuickAnalysisCard(title: 'Total Items', totalItems: adminController.totalItems),
                      QuickAnalysisCard(title: 'Pending Requests'),
                    ),
                    const SizedBox(height: 16),
                    QuickAnalysisCardPair(
                      QuickAnalysisCard(title: 'Total Borrowed'),
                      QuickAnalysisCard(title: 'Active Users'),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CustomText(text: 'Quick Actions', isSubHeading: true),
                    ),
                    const SizedBox(height: 16),
                    QuickActionButton(),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CustomText(text: 'Recent Activities', isSubHeading: true,),
                    ),
                    const SizedBox(height: 16,),
                    RecentActivityCard(title: 'Request Approved', msg: 'Approved request for \'Football\''),
                    const SizedBox(height: 16,),
                    RecentActivityCard(title: 'Request Approved', msg: 'Approved request for \'Football\''),
                    const SizedBox(height: 16,),
                    RecentActivityCard(title: 'Request Approved', msg: 'Approved request for \'Football\''),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
                    ),
          );
        // : Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget QuickAnalysisCardPair(Widget card1, Widget card2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(children: [Expanded(child: card1), Expanded(child: card2)]),
    );
  }

  Widget QuickAnalysisCard({required String title, int totalItems = 0}) {
    return SizedBox(
      // height: 120,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: title, isContent: true),
              const SizedBox(height: 4),
              CustomText(text: '$totalItems', isHeading: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget QuickActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            // width: MediaQuery.of(context).size.width * 0.45,
            height: 80,
            child: Card(
              child: CustomElevatedIconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(AppRouteName.categoryRouteName);
                },
                icon: CircleAvatar(minRadius: 14, child: Icon(Icons.add)),
                label: CustomText(text: 'Add Category', isContent: true),
              ),
            ),
          ),
          // const SizedBox(width: 12,),
          Expanded(
            child: SizedBox(
              height: 80,
              child: Card(
                child: CustomElevatedIconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(AppRouteName.addItemRouteName);
                  },
                  icon: CircleAvatar(minRadius: 14, child: Icon(Icons.add)),
                  label: CustomText(text: 'Add Item', isContent: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget RecentActivityCard({required String title, required String msg, String duration = '2 hours ago'}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomText(text: title,isSubHeading: true),
              const SizedBox(height: 12,),
              CustomText(text: msg,isContent: true,color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white60
                  : Colors.black38,),
              const SizedBox(height: 12,),
              CustomText(text: duration, isSmallText: true,color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white60
                  : Colors.black38,)
            ],),
          ),
        ),
      ),
    );
  }
}
