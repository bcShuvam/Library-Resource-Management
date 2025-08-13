import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/bottom_navigation/widget/custom_bottom_navigation.dart';
import 'package:library_resource_management/app/modules/category/controller/category_controller.dart';
import 'package:library_resource_management/app/modules/profile/controller/profile_controller.dart';
import 'package:library_resource_management/themes/custom_colors.dart';
import 'package:library_resource_management/widgets/buttons/custom_elevated_button.dart';
import 'package:library_resource_management/widgets/text_form_field/custom_text_form_field.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController? categoryController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryController>(context, listen: false).fetchCategories();
      Provider.of<ProfileController>(context, listen: false).fetchProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body(), bottomNavigationBar: CustomBottomNavBar(),);
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Categories',
        style: TextStyle(
          fontSize: 22,
          letterSpacing: 0.8,
          fontWeight: FontWeight.bold,
        ),
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
        return SingleChildScrollView(
          child: Consumer<ProfileController>(
            builder: (context, profileController, _) {
              return Column(
                children: [
                  profileController.role == 'Admin'
                      ? const SizedBox(height: 16)
                      : const SizedBox.shrink(),
                  profileController.role == 'Admin'
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomElevatedIconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                context: context,
                                builder:
                                    (context) =>
                                        createCategoryBottomSheet(context),
                              );
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                            label: CustomText(
                              text: 'Add Category',
                              isSubHeading: true,
                            ),
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomTextFromField(
                      controller: categoryController.searchCategory,
                      applyPrefix: true,
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Search categories...',
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 300));
                      categoryController.fetchCategories();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      shrinkWrap: true,
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryController.searchResults.length,
                      itemBuilder: (context, index) {
                        String id = categoryController.searchResults[index].id;
                        String category =
                            categoryController.searchResults[index].category;
                        int totalItems =
                            categoryController.searchResults[index].totalItems;
                        return Card(
                          child: ListTile(
                            onTap: () {
                              categoryController.getCatalogByCategory(
                                context,
                                categoryId: id,
                              );
                            },
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  child: Icon(Icons.grid_view_outlined),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: category,
                                      isSubHeading: true,
                                    ),
                                    CustomText(
                                      text: '$totalItems items',
                                      isSubContent: true,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                profileController.role == 'Admin' ?
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(Icons.edit),
                                    ),
                                    const SizedBox(width: 16),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: SingleChildScrollView(
                                                child: Card(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  elevation: 3,
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 24,
                                                        ),
                                                        CustomText(
                                                          text:
                                                              'Delete category "$category"?',
                                                          isHeading: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            CustomElevatedIconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              icon: Icon(
                                                                FontAwesomeIcons
                                                                    .x,
                                                              ),
                                                              label: CustomText(
                                                                text: 'Cancel',
                                                                isContent: true,
                                                              ),
                                                            ),
                                                            CustomElevatedIconButton(
                                                              onPressed: () {
                                                                categoryController
                                                                    .deleteCategory(
                                                                      context,
                                                                      id: id,
                                                                    );
                                                              },
                                                              backgroundColor:
                                                                  CustomColors
                                                                      .lightRed,
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              label: CustomText(
                                                                text: 'Delete',
                                                                isContent: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 24,
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
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ) : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget createCategoryBottomSheet(context) {
    return Consumer<CategoryController>(
      builder: (context, categoryController, _) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      CustomText(
                        text: 'Category Name',
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 4),
                      CustomTextFromField(
                        controller: categoryController.name,
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Category name is required'
                              : null;
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        text: 'Description',
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 4),
                      CustomTextFromField(
                        controller: categoryController.description,
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Description is required'
                              : null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            categoryController.addCategory(context);
                          } else {
                            debugPrint('Form is not valid');
                          }
                        },
                        width: 1,
                        height: 50,
                        widget: CustomText(text: 'Add', isSubHeading: true),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
