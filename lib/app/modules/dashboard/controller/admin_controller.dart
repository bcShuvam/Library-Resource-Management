import 'package:flutter/material.dart';
import 'package:library_resource_management/app/modules/category/controller/category_controller.dart';
import 'package:library_resource_management/app/modules/dashboard/models/category_response_model.dart';
import 'package:library_resource_management/app/modules/profile/controller/profile_controller.dart';
import 'package:library_resource_management/app/utils/snackbar_utils.dart';

import '../../../../core/end_points.dart';
import '../../../../core/http_service.dart';

class AdminController extends ChangeNotifier{
  final ProfileController profileController;
  final CategoryController categoryController;

  AdminController(this.profileController, this.categoryController);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _totalItems = 0;

  int get totalItems => _totalItems;

  void fetchAdminDashboard() {
    _isLoading = true;
    notifyListeners();
    _totalItems;
    profileController.fetchProfile();
    categoryController.fetchCategories();
    _isLoading = false;
    notifyListeners();
  }

  void fetchAdmin(context) async {
    final response = await HttpService.get(endpoint: EndPoints.adminDashboard);
    if(response.containsKey('error')){
      if (context.mounted) {
        SnackBarUtils.showErrorSnackbar(context, message: response['error']);
      }
      return;
    }

    _totalItems = response['totalItems'];

    // ✅ prevent notifyListeners after dispose
    if (hasListeners) notifyListeners();

    debugPrint('TotalItems = $_totalItems');
  }
}