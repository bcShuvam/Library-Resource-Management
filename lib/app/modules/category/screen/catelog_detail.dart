import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/category/controller/category_controller.dart';
import 'package:library_resource_management/app/modules/profile/controller/profile_controller.dart';
import 'package:library_resource_management/app/utils/image_path_utils.dart';
import 'package:library_resource_management/widgets/buttons/custom_elevated_button.dart';
import 'package:library_resource_management/widgets/text_form_field/custom_text_form_field.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

class CatalogDetailScreen extends StatefulWidget {
  const CatalogDetailScreen({super.key});

  @override
  State<CatalogDetailScreen> createState() => _CatalogDetailScreenState();
}

class _CatalogDetailScreenState extends State<CatalogDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: FadeTransition(opacity: _fadeAnimation, child: _body()),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Catalog Detail',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.8,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          size: 26,
        ),
        onPressed: () => context.pop(),
        tooltip: 'Back',
      ),
    );
  }

  Widget _body() {
    return Consumer<CategoryController>(
      builder: (context, categoryController, _) {
        final catalog = categoryController.catalogDetail.catalog!;
        final availableQuantity = catalog.quantity - catalog.borrowedQuantity;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Material(
            borderRadius: BorderRadius.circular(25),
            elevation: 8,
            // shadowColor: Colors.black26,
            // color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image with smooth fade and rounded corners
                  Hero(
                    tag: catalog.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: SizedBox(
                        height: 360,
                        width: double.infinity,
                        child: Image.network(
                          ImagePathUtils.getRelativePath(catalog.image),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!
                                        : null,
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Catalog title
                  Text(
                    catalog.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepPurple,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 14),

                  // Description with soft text style & line spacing
                  Text(
                    catalog.description,
                    style: TextStyle(
                      fontSize: 17,
                      // color: Colors.grey.shade800,
                      height: 1.4,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.fade,
                  ),

                  const SizedBox(height: 30),

                  // Quantities block in cards with soft shadows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _quantityCard('Total', catalog.quantity, Colors.blue),
                      _quantityCard(
                        'Borrowed',
                        catalog.borrowedQuantity,
                        Colors.orange.shade700,
                      ),
                      _quantityCard(
                        'Available',
                        availableQuantity,
                        Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Buttons with smooth animations, shadows, and spacing
                  Consumer<ProfileController>(
                    builder: (context, profileController, _) {
                      final isAdmin = profileController.role == 'Admin';

                      if (isAdmin) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 26,
                                  ),
                                  elevation: 6,
                                  shadowColor: Colors.redAccent,
                                ),
                                icon: const Icon(FontAwesomeIcons.trash, color: Colors.white,),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(context: context, builder: (context){
                                    return Center(
                                      child: Card(
                                        margin: EdgeInsets.all(16),
                                        child: ListTile(
                                          title: CustomText(text: 'Are you sure you want to delete this catalog?', isSubHeading: true,maxLines: 3,),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red.shade600,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 26,
                                                    ),
                                                    elevation: 6,
                                                    shadowColor: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    categoryController.deleteCatalogById(context, id: catalog.id);
                                                    context.pop();
                                                  },
                                                  child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                                                ),
                                                const SizedBox(width: 12,),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey.shade600,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 26,
                                                    ),
                                                    elevation: 6,
                                                    shadowColor: Colors.grey.shade400,
                                                  ),
                                                  onPressed: () => context.pop(),
                                                  child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 28,
                                  ),
                                  elevation: 6,
                                  shadowColor: Colors.greenAccent,
                                ),
                                icon: const Icon(FontAwesomeIcons.pen, color: Colors.white,),
                                label: const Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                context: context,
                                builder: (context) => requestBottomSheet(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 30,
                              ),
                              elevation: 6,
                              shadowColor: Colors.indigoAccent,
                            ),
                            child: const Text(
                              'Request to Borrow',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _quantityCard(String label, int value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            // BoxShadow(
            //   color: color.withOpacity(0.25),
            //   blurRadius: 12,
            //   offset: const Offset(0, 6),
            // ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '$value',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: 0.7,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestBottomSheet() {
    return Consumer<CategoryController>(
      builder: (context, categoryController, _) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Platform.isIOS
                              ? Icons.arrow_back_ios
                              : Icons.arrow_back,
                          size: 24,
                        ),
                        onPressed: () => context.pop(),
                        tooltip: 'Back',
                      ),
                      const SizedBox(width: 12),
                      CustomText(text: 'Borrow Request', isSubHeading: true),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: 'Purpose of Borrowing'),
                        const SizedBox(height: 4),
                        CustomTextFromField(
                          controller: categoryController.purpose,
                          minLine: 4,
                          maxLines: 4,
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please Enter Borrowing Purpose'
                                : value.length < 3
                                ? 'Purpose must be 3 character long'
                                : null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomText(text: 'Quantity'),
                        const SizedBox(height: 4),
                        CustomTextFromField(
                          controller: categoryController.quantity,
                          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter quantity';
                            }

                            // Check if value is a valid integer
                            final int? quantity = int.tryParse(value);
                            if (quantity == null) {
                              return 'Only numbers are allowed';
                            }

                            if (quantity <= 0) {
                              return 'Quantity must be greater than 0';
                            }

                            final availableQuantity = categoryController.catalogDetail.catalog!.quantity -
                                categoryController.catalogDetail.catalog!.borrowedQuantity;

                            if (quantity > availableQuantity) {
                              return 'Quantity must be less than or equal to $availableQuantity';
                            }

                            return null; // valid
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomText(text: 'Return Date and Time'),
                        const SizedBox(height: 4),
                        CustomTextFromField(
                          controller: categoryController.returnDateTime,
                          minLine: 1,
                          maxLines: 1,
                          readOnly: true,
                          onTap: () {
                            categoryController.selectDate(context);
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please select return date and time'
                                : null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              categoryController.sendBorrowRequest(context);
                              debugPrint('Valid');
                            }
                          },
                          width: 1,
                          widget: CustomText(
                            text: 'Confirm Request',
                            isSubHeading: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
