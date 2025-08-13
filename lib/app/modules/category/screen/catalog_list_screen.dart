import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/category/controller/category_controller.dart';
import 'package:library_resource_management/app/modules/profile/controller/profile_controller.dart';
import 'package:library_resource_management/app/utils/image_path_utils.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

class CatalogListScreen extends StatefulWidget {
  const CatalogListScreen({super.key});

  @override
  State<CatalogListScreen> createState() => _CatalogListScreenState();
}

class _CatalogListScreenState extends State<CatalogListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Catalogs',
        style: TextStyle(fontSize: 22,
            letterSpacing: 0.8,fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _body() {
    return Consumer<CategoryController>(
      builder: (context, categoryController, _) {
        return Consumer<ProfileController>(
          builder: (context, profileController, _) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileController.profile.role == 'Admin' ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: categoryController.catalogs.category!.category, isHeading: true),
                            CustomText(text: '${categoryController.catalogs.category!.totalItems} items available', isSubHeading: true),
                          ],
                        ),
                        InkWell(
                            onTap: (){
                              showDialog(context: context, builder: (context){
                                return Center(child: Card(child: CustomText(text: 'Filter')),);
                              });
                            },
                            child: Icon(FontAwesomeIcons.filter)),
                      ],
                    ) : SizedBox.shrink(),
                    const SizedBox(height: 16,),
                    ListView.builder(
                      shrinkWrap: true,
                        primary: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categoryController.catalogs.catalogs!.length,
                        itemBuilder: (context, index){
                        String image = ImagePathUtils.getRelativePath(categoryController.catalogs.catalogs![index].image);
                        // String image = '${EndPoints.baseUrl}$imageRelativePath';
                        String id = categoryController.catalogs.catalogs![index].id;
                        String name = categoryController.catalogs.catalogs![index].name;
                        int quantity = categoryController.catalogs.catalogs![index].quantity;
                        int borrowedQuantity = categoryController.catalogs.catalogs![index].borrowedQuantity;
                        int availableQuantity = quantity - borrowedQuantity;
                      return InkWell(
                          onTap: (){
                            categoryController.getCatalogById(context, id: id);
                          },
                          child: catalogCard(image: image, name: name, quantity: quantity, borrowed: borrowedQuantity, availableQuantity: availableQuantity));
                    })
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget catalogCard({
    required String image,
    required String name,
    required int quantity,
    required int borrowed,
    required int availableQuantity,
  }) {
    return Consumer<CategoryController>(
      builder: (context, categoryController, _) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 150,
                          width: 150,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        // isSubHeading: true,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),

                      // Quantity row
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: quantity.toString(),
                              isContent: true,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: CustomText(
                              text: 'Total',
                              isSubContent: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Borrowed row
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: borrowed.toString(),
                              isContent: true,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: CustomText(
                              text: 'Borrowed',
                              isSubContent: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Available row
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: availableQuantity.toString(),
                              isContent: true,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: CustomText(
                              text: 'Available',
                              isSubContent: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
