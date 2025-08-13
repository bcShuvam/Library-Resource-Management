import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_resource_management/app/modules/borrow/controller/borrow_controller.dart';
import 'package:library_resource_management/app/utils/date_time_utils.dart';
import 'package:library_resource_management/themes/custom_colors.dart';
import 'package:library_resource_management/widgets/buttons/custom_elevated_button.dart';
import 'package:library_resource_management/widgets/dropdown/custom_dropdown.dart';
import 'package:library_resource_management/widgets/text_form_field/custom_text_form_field.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

import '../../bottom_navigation/widget/custom_bottom_navigation.dart';

class BorrowRequestsListScreen extends StatefulWidget {
  const BorrowRequestsListScreen({super.key});

  @override
  State<BorrowRequestsListScreen> createState() =>
      _BorrowRequestsListScreenState();
}

class _BorrowRequestsListScreenState extends State<BorrowRequestsListScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BorrowRequestController>(
        context,
        listen: false,
      ).fetchBorrowRequests(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Borrow Requests',
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
    final theme = Theme.of(context);
    return Consumer<BorrowRequestController>(
      builder: (context, borrowReqController, _) {
        final requests = borrowReqController.borrowRequest.requests;
        // if (requests == null || requests.isEmpty) {
        //   return Center(child: CustomText(text: 'No Request found'));
        // }

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                borrowReqController.fetchBorrowRequests(context);
              },
              child:
                  requests == null || requests.isEmpty
                      ? Center(child: CustomText(text: 'No Request found'))
                      : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 48.0,
                        ),
                        itemCount: requests.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final borrow = requests[index];
                          final user = borrow.user;
                          final catalog = borrow.catalog;

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // User Header
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      radius: 28,
                                      // backgroundColor: Colors., // remove background
                                      child:
                                          user!.photoUrl!.isNotEmpty
                                              ? ClipOval(
                                                child: Image.network(
                                                  user!.photoUrl!,
                                                  fit: BoxFit.cover,
                                                  width: 56,
                                                  height: 56,
                                                  loadingBuilder: (
                                                    context,
                                                    child,
                                                    loadingProgress,
                                                  ) {
                                                    if (loadingProgress == null)
                                                      return child; // loaded
                                                    return const Center(
                                                      child: SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) {
                                                    return const Icon(
                                                      Icons.person,
                                                      size: 32,
                                                    );
                                                  },
                                                ),
                                              )
                                              : const Icon(
                                                Icons.person,
                                                size: 32,
                                              ),
                                    ),
                                    title: Text(
                                      user!.fullName!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      'Student ID: ${user.email!.split('@')[0]}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    trailing: Chip(
                                      label: Text(
                                        borrow!.reqStatus!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: _statusColor(
                                        borrow!.reqStatus!,
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8),

                                  // Catalog Info
                                  Text(
                                    catalog!.name!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (borrow.description!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        borrow!.description!,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),

                                  const SizedBox(height: 12),

                                  // Quantity Row
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 4,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          borrowReqController
                                              .setReqQuantityValue(
                                                borrow!.quantity!,
                                              );
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: SingleChildScrollView(
                                                  child: Card(
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16.0,
                                                          vertical: 8.0,
                                                        ),
                                                    elevation: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            16.0,
                                                          ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Edit Request Quantity',
                                                            isHeading: true,
                                                          ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),

                                                          // Form
                                                          Form(
                                                            key: _formKey,
                                                            child: CustomTextFromField(
                                                              controller:
                                                                  borrowReqController
                                                                      .reqQuantity,
                                                              keyboardType:
                                                                  const TextInputType.numberWithOptions(
                                                                    signed:
                                                                        false,
                                                                    decimal:
                                                                        false,
                                                                  ),
                                                              prefixIcon: Icon(
                                                                FontAwesomeIcons
                                                                    .calculator,
                                                              ),
                                                              validator: (
                                                                value,
                                                              ) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Please enter quantity';
                                                                }

                                                                final parsedValue =
                                                                    int.tryParse(
                                                                      value,
                                                                    );
                                                                if (parsedValue ==
                                                                    null) {
                                                                  return 'Quantity must be a number';
                                                                }

                                                                if (parsedValue ==
                                                                    0) {
                                                                  return '0 quantity cannot be allotted';
                                                                }

                                                                if (parsedValue <
                                                                        1 ||
                                                                    parsedValue >
                                                                        catalog!
                                                                            .availableQuantity!) {
                                                                  return 'Exceeded available quantity i.e ${catalog.availableQuantity}';
                                                                }

                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),

                                                          // Buttons Row
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CustomElevatedIconButton(
                                                                  onPressed: () {
                                                                    borrowReqController
                                                                        .setReqQuantityValue(
                                                                          borrow
                                                                              .quantity!,
                                                                        );
                                                                  },
                                                                  icon: const Icon(
                                                                    FontAwesomeIcons
                                                                        .rotate,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  label: CustomText(
                                                                    text:
                                                                        'Reset',
                                                                    isContent:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 12,
                                                              ),
                                                              Expanded(
                                                                child: CustomElevatedIconButton(
                                                                  onPressed: () {
                                                                    if (_formKey
                                                                            .currentState
                                                                            ?.validate() ??
                                                                        false) {
                                                                      int
                                                                      quantity = int.parse(
                                                                        borrowReqController
                                                                            .reqQuantity
                                                                            .text,
                                                                      );
                                                                      borrowReqController.setAllottedQuantity(
                                                                        value:
                                                                            quantity,
                                                                        index:
                                                                            index,
                                                                      );
                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    }
                                                                  },
                                                                  backgroundColor:
                                                                      CustomColors
                                                                          .jadeGreen,
                                                                  icon: const Icon(
                                                                    FontAwesomeIcons
                                                                        .check,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  label: CustomText(
                                                                    text:
                                                                        'Allot',
                                                                    isContent:
                                                                        true,
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
                                            },
                                          );
                                          debugPrint(
                                            'Req Quantity: ${borrow.quantity}',
                                          );
                                        },
                                        child: _infoChip(
                                          Icons.shopping_bag,
                                          'Req Quantity: ${borrow.quantity}',
                                        ),
                                      ),
                                      _infoChip(
                                        Icons.list,
                                        'Total: ${catalog!.quantity}',
                                      ),
                                      _infoChip(
                                        Icons.assignment_return,
                                        'Borrowed: ${catalog.borrowedQuantity!}',
                                      ),
                                      _infoChip(
                                        Icons.inventory_2,
                                        'Available: ${catalog.availableQuantity}',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Date Info
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Requested: ${DateTimeUtils.convertToLocalTime(borrow.borrowReqDate.toString())}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'Return: ${DateTimeUtils.convertToLocalTime(borrow.returnDate.toString())}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Action Buttons
                                  borrow.reqStatus == 'Pending'
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomElevatedIconButton(
                                            onPressed: () async {
                                              await approveRejectDialog(
                                                index: index,
                                                title: 'Cancel',
                                                fullName: user!.fullName!,
                                                catalogName: catalog!.name!,
                                                quantity: borrow.quantity!,
                                                returnDate: borrow.returnDate!,
                                                onTapConfirm: () async {
                                                  borrowReqController
                                                      .approveRejectBorrowRequest(
                                                        context,
                                                        reqStatus: 'Approved',
                                                        index: index,
                                                      );
                                                },
                                              );
                                            },
                                            backgroundColor:
                                                CustomColors.jadeGreen,
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            label: CustomText(
                                              text: 'Approve',
                                              isSubHeading: true,
                                            ),
                                          ),
                                          CustomElevatedIconButton(
                                            onPressed: () async {
                                              await approveRejectDialog(
                                                index: index,
                                                title: 'Reject',
                                                fullName: user!.fullName!,
                                                catalogName: catalog!.name!,
                                                quantity: borrow.quantity!,
                                                returnDate: borrow.returnDate!,
                                                onTapConfirm: () {
                                                  borrowReqController
                                                      .approveRejectBorrowRequest(
                                                        context,
                                                        reqStatus: 'Rejected',
                                                        index: index,
                                                      );
                                                },
                                              );
                                            },
                                            backgroundColor:
                                                CustomColors.lightRed,
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            label: CustomText(
                                              text: 'Reject',
                                              isSubHeading: true,
                                            ),
                                          ),
                                        ],
                                      )
                                      : SizedBox.shrink(),

                                  if (borrow.reqStatus == 'Rejected')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        CustomText(
                                          text: 'Request Rejected',
                                          isSubHeading: true,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          'Rejected: ${DateTimeUtils.convertToLocalTime(borrow.borrowReqRejectDate.toString())}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Description: ${borrow.reqStatusDescription}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (borrow.reqStatus == 'Approved')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        CustomText(
                                          text: 'Request Approved',
                                          isSubHeading: true,
                                          color: CustomColors.jadeGreen,
                                        ),
                                        Text(
                                          'Rejected: ${DateTimeUtils.convertToLocalTime(borrow.borrowReqApproveDate.toString())}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Description: ${borrow.reqStatusDescription}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: CircleAvatar(
                radius: 28,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Filter Requests',
                                      isHeading: true,
                                    ),
                                    const SizedBox(height: 12),
                                    CustomText(text: 'Request Status'),
                                    const SizedBox(height: 4,),
                                    DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      value:
                                          borrowReqController.selectedReqStatus,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: theme.iconTheme.color,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      dropdownColor:
                                          theme
                                              .cardColor, // dropdown panel bg from your theme card color
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color:
                                            theme
                                                .colorScheme
                                                .onSurface, // text color on surfaces (cards)
                                        fontSize: 16,
                                      ),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          borrowReqController
                                              .onChangeReqStatusType(newValue);
                                        }
                                      },
                                      items:
                                          borrowReqController.reqStatusType
                                              .map<DropdownMenuItem<String>>((
                                                String value,
                                              ) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              })
                                              .toList(),
                                    ),
                                    const SizedBox(height: 12),
                                    CustomText(text: 'Request Date'),
                                    const SizedBox(height: 4,),
                                    DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      value:
                                          borrowReqController.selectedReqDateType,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: theme.iconTheme.color,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      dropdownColor:
                                          theme
                                              .cardColor, // dropdown panel bg from your theme card color
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color:
                                            theme
                                                .colorScheme
                                                .onSurface, // text color on surfaces (cards)
                                        fontSize: 16,
                                      ),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          borrowReqController
                                              .onChangeReqDateType(newValue);
                                        }
                                      },
                                      items:
                                          borrowReqController.reqDateType
                                              .map<DropdownMenuItem<String>>((
                                                String value,
                                              ) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              })
                                              .toList(),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          widget: CustomText(
                                            text: 'Cancel',
                                            isContent: true,
                                          ),
                                        ),
                                        CustomElevatedButton(
                                          onPressed: () {
                                            borrowReqController
                                                .onTapApplyFilter(context);
                                            Navigator.pop(context);
                                          },
                                          widget: CustomText(
                                            text: 'Apply',
                                            isContent: true,
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
                      },
                    );
                  },
                  child: Icon(
                    FontAwesomeIcons.filter,
                    color: CustomColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
      avatar: Icon(icon, size: 16, color: Colors.blueGrey),
      backgroundColor: Colors.grey.shade200,
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future approveRejectDialog({
    required int index,
    required String title,
    required String fullName,
    required String catalogName,
    required int quantity,
    required DateTime returnDate,
    required Function() onTapConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: '$title Borrow Request?', isHeading: true),
                    const SizedBox(height: 12),
                    CustomText(
                      text:
                          '$title $fullName\'s borrow request for "$catalogName" with allotted quantity "$quantity" and return date "${DateTimeUtils.convertToLocalTime(returnDate.toString())}".',
                      maxLines: 7,
                    ),
                    const SizedBox(height: 16),

                    // Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            widget: CustomText(text: 'Cancel', isContent: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: onTapConfirm,
                            backgroundColor:
                                title == 'Reject'
                                    ? CustomColors.lightRed
                                    : CustomColors.jadeGreen,
                            widget: CustomText(
                              text: 'Confirm',
                              isContent: true,
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
      },
    );
  }
}
