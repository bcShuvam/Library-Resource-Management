import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:library_resource_management/app/modules/bottom_navigation/widget/custom_bottom_navigation.dart';
import 'package:library_resource_management/app/modules/request/model/borrow_%20request_list_response_model.dart';
import 'package:library_resource_management/app/utils/image_path_utils.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/container/custom_container.dart';
import '../../../utils/date_time_utils.dart';
import '../controller/borrow_controller.dart';

class MyBorrowRequestScreen extends StatefulWidget {
  const MyBorrowRequestScreen({super.key});

  @override
  State<MyBorrowRequestScreen> createState() => _MyBorrowRequestScreenState();
}

class _MyBorrowRequestScreenState extends State<MyBorrowRequestScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyBorrowRequestController>(
        context,
        listen: false,
      ).fetchMyBorrowRequest(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'My Requests',
        style: TextStyle(
          fontSize: 22,
          letterSpacing: 0.8,
          fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 2,
    );
  }

  Widget _body() {
    return Consumer<MyBorrowRequestController>(
      builder: (context, borrowReqController, _) {
        final requests = borrowReqController.myBorrowRequest.requests;
        if (requests == null || requests.isEmpty) {
          return Center(
            child: CustomText(
              text: 'No Borrow requests found',
              size: 18,
              color: Colors.grey.shade600,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            borrowReqController.fetchMyBorrowRequest(context);
          },
          child: Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 32, 12, 24),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final borrowRequest = requests[index];
                  String image = ImagePathUtils.getRelativePath(
                    borrowRequest.catalogImage,
                  );
                  DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm');
                  // final dueDate = formatter.format(borrowRequest.borrowReqDate);
                  final dueDate = DateTimeUtils.convertToLocalTime(borrowRequest.returnDate.toString());
                  return borrowReqCard(
                    category: borrowRequest.categoryName ?? 'Unknown Category',
                    catalog: borrowRequest.catalogName ?? 'Unknown Catalog',
                    dueDate: dueDate,
                    status: borrowRequest.reqStatus,
                    imageUrl: image,
                  );
                },
              ),
              Positioned(
                top: 12,
                right: 16,
                child: Icon(
                  FontAwesomeIcons.filter,
                  size: 20,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget borrowReqCard({
    required String category,
    required String catalog,
    required String dueDate,
    required String status,
    String imageUrl =
    'https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg?cs=srgb&dl=pexels-pixabay-47730.jpg&fm=jpg',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: CustomContainer(
        horizontalMargin: 0,
        verticalMargin: 0,
        horizontalPad: 12,
        verticalPad: 12,
        applyShadow: true,
        borderRadius: 16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed size & rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      height: 120,
                      width: 120,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Flexible text container to prevent overflow
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category text - smaller & muted
                  CustomText(
                    text: category,
                    isContent: true,
                    fontWeight: FontWeight.w600,
                    size: 14,
                    color: Colors.grey.shade700,
                  ),

                  const SizedBox(height: 6),

                  // Catalog name - bigger, bold, max 2 lines with ellipsis overflow
                  CustomText(
                    text: catalog,
                    isContent: true,
                    fontWeight: FontWeight.bold,
                    size: 18,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Due date - italic and subtle
                  CustomText(
                    text: dueDate,
                    isSubContent: true,
                    size: 13,
                    style: FontStyle.italic,
                    maxLines: 2,
                    color: Colors.grey.shade600,
                  ),

                  const SizedBox(height: 12),

                  // Status badge with color coding
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange.shade700;
      case 'approved':
        return Colors.green.shade700;
      case 'rejected':
        return Colors.red.shade700;
      case 'returned':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}
