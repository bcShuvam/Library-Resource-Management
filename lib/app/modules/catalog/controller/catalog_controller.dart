import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_resource_management/app/modules/catalog/model/catalog_create_model.dart';
import 'package:library_resource_management/app/modules/catalog/model/category_name_model.dart';
import 'package:library_resource_management/app/modules/category/controller/category_controller.dart';
import 'package:library_resource_management/app/modules/category/model/category_response_model.dart';
import 'package:library_resource_management/app/utils/snackbar_utils.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/core/http_service.dart';

import '../../../../themes/custom_colors.dart';

class CatalogController extends ChangeNotifier {
  final CategoryController categoryController;
  CatalogController(this.categoryController);

  CatalogPayload catalogPayload = CatalogPayload();
  List<CategoryNameModel> _categories = [];
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  bool _availabilityStatus = false;
  String _selectedCategory = '';
  File? _selectedImage;
  bool _isImageLoading = false;

  List<CategoryNameModel> get categories => _categories;
  TextEditingController get name => _name;
  TextEditingController get description => _description;
  TextEditingController get quantity => _quantity;
  bool get availabilityStatus => _availabilityStatus;
  String get selectedCategory => _selectedCategory;
  File? get selectedImage => _selectedImage;
  bool get isImageLoading => _isImageLoading;
  Color borderColor = Colors.grey;

  void toggleBorderColor() {
    borderColor = _selectedImage == null ? Colors.red : Colors.grey;
    notifyListeners();
  }

  void setSelectedCategory(String value) {
    _selectedCategory = value;
    debugPrint('${_categories[selectedCategoryIndex].toJson()}');
    notifyListeners();
  }

  int get selectedCategoryIndex =>
      _categories.indexWhere((cat) => cat.category == _selectedCategory);

  Future pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    _isImageLoading = true;
    notifyListeners();

    if (returnedImage == null) {
      _isImageLoading = false;
      notifyListeners();
      return;
    }

    _selectedImage = File(returnedImage.path);
    toggleBorderColor();

    await Future.delayed(const Duration(seconds: 7));
    _isImageLoading = false;
    notifyListeners();
  }

  Future pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    _isImageLoading = true;
    notifyListeners();

    if (returnedImage == null) {
      _isImageLoading = false;
      notifyListeners();
      return;
    }

    _selectedImage = File(returnedImage.path);
    toggleBorderColor();

    await Future.delayed(const Duration(seconds: 7));
    _isImageLoading = false;
    notifyListeners();
  }

  void fetchCategoriesName() async {
    final response = await HttpService.get(endpoint: EndPoints.categoriesName);

    // Assuming `response` is List<dynamic> (i.e., parsed JSON array)
    _categories =
        response
            .map<CategoryNameModel>((e) => CategoryNameModel.fromJson(e))
            .toList();

    debugPrint('$_categories');
    debugPrint('${_categories[0].category}');
    notifyListeners();
  }

  void clearForm() {
    _categories.clear();
    _name.clear();
    _description.clear();
    _quantity.clear();
    _selectedImage = null;
    _selectedCategory = '';
    notifyListeners();
  }

  void fetchNewCatalog(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(color: CustomColors.primaryColor),
        );
      },
    );
    final payload = {
      "categoryId": _categories[selectedCategoryIndex].id,
      "name": _name.value.text,
      "description": _description.value.text,
      "quantity": _quantity.value.text,
    };
    debugPrint('$payload');
    final response = await HttpService.postFilesRequest(
      endpoint: EndPoints.catalog,
      payload: payload,
      name: 'image',
      selectedImage: _selectedImage,
    );
    debugPrint('$response');
    if (response.containsKey('message')) {
      SnackBarUtils.showSuccessSnackbar(context, message: response['message']);
      Navigator.pop(context);
      Navigator.pop(context);
      clearForm();
    } else {
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
      Navigator.pop(context);
    }
  }
}
