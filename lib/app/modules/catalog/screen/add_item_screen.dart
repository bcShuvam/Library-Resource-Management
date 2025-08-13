import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/catalog/controller/catalog_controller.dart';
import 'package:library_resource_management/themes/custom_colors.dart';
import 'package:library_resource_management/widgets/buttons/custom_elevated_button.dart';
import 'package:library_resource_management/widgets/container/custom_container.dart';
import 'package:library_resource_management/widgets/dropdown/custom_dropdown.dart';
import 'package:library_resource_management/widgets/text_form_field/custom_text_form_field.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CatalogController>(
        context,
        listen: false,
      ).fetchCategoriesName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Catalog',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _body() {
    return Consumer<CatalogController>(
      builder: (context, catalog, _) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Add New Item', isHeading: true),
                  const Divider(),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          useSafeArea: true,
                          context: context,
                          builder: (context) =>
                              _chooseImageFrom());
                    },
                    child: DottedBorder(
                      borderType:
                          BorderType
                              .RRect, // Can be BorderType.Circle, BorderType.Rect, etc.
                      radius: Radius.circular(12),
                      dashPattern: [6, 3], // 6 is dash length, 3 is space
                      color: catalog.borderColor,
                      strokeWidth: 2,
                      child: catalog.selectedImage == null ? Container(
                        height: 200,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_outlined, size: 48),
                              CustomText(
                                text: 'Upload item image',
                                fontWeight: FontWeight.w500,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ) : SizedBox(height: 200,
                      child: Center(child: catalog.isImageLoading == true ? CircularProgressIndicator() : Image.file(catalog.selectedImage!, fit: BoxFit.fill,)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomText(text: 'Item Name', isContent: true),
                  const SizedBox(height: 4,),
                  CustomTextFromField(
                    controller: catalog.name,
                    validator: (value) {
                      return value!.isEmpty ? 'Name is required' : value.length < 3 ? 'Name must be 3 character long' : null;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomText(text: 'Description', isContent: true),
                  const SizedBox(height: 4,),
                  CustomTextFromField(
                    controller: catalog.description,
                    validator: (value) {
                      return value!.isEmpty ? 'description is required' : value.length < 3 ? 'description must be 3 character long' : null;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomText(text: 'Quantity', isContent: true),
                  const SizedBox(height: 4,),
                  CustomTextFromField(
                    controller: catalog.quantity,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Quantity is required';
                      }
                      final number = int.tryParse(value);
                      if (number == null) {
                        return 'Only numeric values are allowed';
                      }
                      if (number <= 0) {
                        return 'Quantity must be greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomText(text: 'Category', isContent: true),
                  const SizedBox(height: 4,),
                  DropdownButtonFormField<String>(
                    items:
                        catalog.categories.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat.category,
                            child: Text(cat.category),
                          );
                        }).toList(),
                      decoration: InputDecoration(
                    fillColor: Colors.white,
                    // focusColor: CustomColors.primaryWhite,
                    // labelText: labelText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                    onChanged:
                        (newValue) => catalog.setSelectedCategory(newValue!),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null){
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    onPressed: () {
                      if(_formKey.currentState != null && _formKey.currentState!.validate()){
                        if(catalog.selectedImage == null){
                          catalog.toggleBorderColor();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Card(
                                  child: ListTile(
                                    title: CustomText(text: 'Please upload an image!', size: 24, fontWeight: FontWeight.w500,),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, widget: CustomText(text:'Close', isContent: true,)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        if(catalog.selectedImage != null){
                          catalog.toggleBorderColor();
                          catalog.fetchNewCatalog(context);
                        }
                      }else{
                        catalog.toggleBorderColor();
                        debugPrint('Form is not valid');
                      }
                    },
                    widget: CustomText(text: 'Save Item', isSubHeading: true),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _chooseImageFrom(){
    return Consumer<CatalogController>(
      builder: (context, cat, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomElevatedIconButton(
                  backgroundColor: CustomColors.lightRed,
                    width: MediaQuery.of(context).size.width,
                    onPressed: (){
                      Navigator.pop(context);
                    cat.pickImageFromGallery();
                    }, icon: Icon(FontAwesomeIcons.image,size: 24, color: Colors.white,), label: CustomText(text: 'Pick Image from Gallery', size: 18,fontWeight: FontWeight.w500,)),
                const SizedBox(height: 16,),
                CustomElevatedIconButton(
                  backgroundColor: CustomColors.jadeGreen,
                    width: MediaQuery.of(context).size.width,
                    onPressed: (){
                      Navigator.pop(context);
                      cat.pickImageFromCamera();
                    }, icon: Icon(Icons.camera_alt_outlined,size: 24, color: Colors.white,), label: CustomText(text: 'Pick Image from Camera', size: 18,fontWeight: FontWeight.w500,)),
              ],
            ),
          ),
        );
      }
    );
  }
}
