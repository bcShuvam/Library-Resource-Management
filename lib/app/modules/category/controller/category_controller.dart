import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_resource_management/app/modules/borrow/model/borrow_request_model.dart';
import 'package:library_resource_management/app/modules/category/model/catalog_detail_response_model.dart';
import 'package:library_resource_management/app/modules/category/model/category_response_model.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/core/http_service.dart';
import 'package:library_resource_management/routes/app_route_names.dart';

import '../../../../themes/custom_colors.dart';
import '../../../utils/snackbar_utils.dart';
import '../../catalog/model/catalog_response_model.dart';
import '../model/catalog_by_category_response_model.dart';

class CategoryController extends ChangeNotifier {
  CategoryResponseModel _categoryResponse = CategoryResponseModel();
  final List<Category> _allCategories = [];
  final List<Category> _searchResults = [];

  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _searchCategory = TextEditingController();
  final TextEditingController _purpose = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _returnDateTime = TextEditingController();
  CatalogByCategoryResponseModel catalogs = CatalogByCategoryResponseModel();
  CatalogDetailResponseModel catalogDetail = CatalogDetailResponseModel();
  String _selectedCatalogId = '';
  DateTime? _picked;
  String _returnDate = '';
  String _returnTime = '';

  int _currentPage = 1;
  bool _isFetching = false;

  // Public Getters
  List<Category> get searchResults => _searchResults;
  List<Category> get allCategories => _allCategories;
  bool get isFetching => _isFetching;
  bool get hasNextPage => _categoryResponse.hasNextPage ?? false;

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  TextEditingController get searchCategory => _searchCategory;
  TextEditingController get purpose => _purpose;
  TextEditingController get quantity => _quantity;
  TextEditingController get returnDateTime => _returnDateTime;
  DateTime? get picked => _picked;

  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    _picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2099),
    );

    if (_picked == null) {
      return;
    } else {
      await selectTime(context, now);
    }

    debugPrint('return date = $_returnDate');
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context, DateTime now) async {
    bool isToday =
        _picked != null &&
        _picked!.year == now.year &&
        _picked!.month == now.month &&
        _picked!.day == now.day;

    TimeOfDay? picked;

    while (true) {
      picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
      );

      if (picked == null) {
        _returnDate = '';
        _returnTime = '';
        _returnDateTime.clear();
        notifyListeners();
        return;
      }

      DateTime selectedDateTime = DateTime(
        _picked!.year,
        _picked!.month,
        _picked!.day,
        picked.hour,
        picked.minute,
      );

      if (isToday &&
          selectedDateTime.isBefore(now.add(const Duration(minutes: 5)))) {
        SnackBarUtils.showErrorSnackbar(
          context,
          message: "Please select a time at least 5 minutes from now",
        );
        continue; // Ask again
      }
      break; // Valid time
    }

    // Only set _returnDate here after valid time is chosen
    _returnDate = '${_picked!.year}-${_picked!.month}-${_picked!.day}';
    _returnTime = '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
    _returnDateTime.text = '$_returnDate $_returnTime';
    debugPrint(_returnDateTime.value.text);

    notifyListeners();
  }

  // Fetch categories with pagination
  void fetchCategories({int page = 1, int limit = 20}) async {
    if (_isFetching) return;
    _isFetching = true;
    notifyListeners();

    try {
      final response = await HttpService.get(
        endpoint: '${EndPoints.categories}?page=$page&limit=$limit',
      );

      final parsed = CategoryResponseModel.fromJson(response);

      if (page == 1) {
        _allCategories.clear();
      }

      _categoryResponse = parsed;
      _currentPage = parsed.currentPage ?? 1;

      _allCategories.addAll(parsed.categories ?? []);
      _searchResults
        ..clear()
        ..addAll(_allCategories);
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  // Fetch next page
  void fetchNextPage() {
    if (hasNextPage) {
      fetchCategories(
        page: _currentPage + 1,
        limit: _categoryResponse.limit ?? 20,
      );
    }
  }

  // Filter categories by keyword
  void searchCategoryByKeyword(String keyword) {
    final lowerKeyword = keyword.toLowerCase().trim();
    if (lowerKeyword.isEmpty) {
      _searchResults
        ..clear()
        ..addAll(_allCategories);
    } else {
      _searchResults
        ..clear()
        ..addAll(
          _allCategories.where(
            (cat) => cat.category.toLowerCase().contains(lowerKeyword),
          ),
        );
    }
    notifyListeners();
  }

  void clearForm() {
    _name.clear();
    _description.clear();
    _searchCategory.clear();
  }

  void addCategory(context) async {
    final payload = {
      "category": _name.value.text,
      "description": _description.value.text,
      "status": true,
    };
    final response = await HttpService.post(
      endpoint: EndPoints.categories,
      payload: payload,
    );
    if (response.containsKey('message')) {
      clearForm();
      SnackBarUtils.showSuccessSnackbar(context, message: response['message']);
      fetchCategories();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
      Navigator.pop(context);
    }
  }

  void deleteCategory(context, {required String id}) async {
    final response = await HttpService.delete(
      endpoint: '${EndPoints.categories}/$id',
    );
    if (response.containsKey('message')) {
      SnackBarUtils.showSuccessSnackbar(context, message: response['message']);
      fetchCategories();
      notifyListeners();
    } else {
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
    }
  }

  void getCatalogByCategory(context, {required String categoryId}) async {
    final response = await HttpService.get(
      endpoint: '${EndPoints.categories}/$categoryId',
    );
    if (response.containsKey('error')) {
      return SnackBarUtils.showErrorSnackbar(
        context,
        message: response['error'],
      );
    } else {
      catalogs = CatalogByCategoryResponseModel.fromJson(response);
      debugPrint('${catalogs.message}');
      debugPrint('${catalogs.category?.toJson()}');
      debugPrint('${catalogs.catalogs![0].toJson()}');
      GoRouter.of(context).pushNamed(AppRouteName.catalogListRouteName);
      notifyListeners();
    }
  }

  void getCatalogById(context, {required String id}) async {
    final response = await HttpService.get(
      endpoint: '${EndPoints.catalog}/$id',
    );
    if (response.containsKey('error')) {
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
    } else {
      _selectedCatalogId = id;
      catalogDetail = CatalogDetailResponseModel.fromJson(response);
      GoRouter.of(context).pushNamed(AppRouteName.catalogDetailRouteName);
      notifyListeners();
    }
  }

  String normalizeDateTime(String raw) {
    final parts = raw.split(' ');
    if (parts.length != 2) return raw;

    final dateParts = parts[0].split('-');
    if (dateParts.length != 3) return raw;

    final year = dateParts[0].padLeft(4, '0');
    final month = dateParts[1].padLeft(2, '0');
    final day = dateParts[2].padLeft(2, '0');

    // Ensure time is hh:mm:ss (add seconds if missing)
    final timeParts = parts[1].split(':');
    String time;
    if (timeParts.length == 2) {
      // hh:mm → add :00 seconds
      time = '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}:00';
    } else if (timeParts.length == 3) {
      // hh:mm:ss → just zero-pad
      time =
      '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}:${timeParts[2].padLeft(2, '0')}';
    } else {
      // fallback
      time = parts[1];
    }

    // Return with space between date and time (not T)
    return '$year-$month-$day $time';
  }

  void sendBorrowRequest(BuildContext context) async {
    try {
      final returnDateTimeStr = _returnDateTime.text.trim();
      DateTime? selectedDateTime;

      try {
        selectedDateTime = DateTime.parse(normalizeDateTime(returnDateTimeStr));
      } catch (_) {
        SnackBarUtils.showErrorSnackbar(
            context, message: 'Invalid return date-time format',
        showOnTop: true
        );
        return;
      }

      if (selectedDateTime.isBefore(
          DateTime.now().add(const Duration(minutes: 5)))) {
        SnackBarUtils.showErrorSnackbar(
          context,
          message: 'Please select a return date-time at least 5 minutes from now',
          showOnTop: true
        );
        return;
      }

      final payload = BorrowRequestModel(
        catalogId: _selectedCatalogId,
        quantity: int.parse(_quantity.text.trim()),
        description: _purpose.text.trim(),
        returnDate: returnDateTimeStr,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final response = await HttpService.post(
        endpoint: EndPoints.borrow,
        payload: payload.toJson(),
      );

      Navigator.pop(context);

      if (response.containsKey('error')) {
        SnackBarUtils.showErrorSnackbar(context, message: response['error']);
      } else {
        _selectedCatalogId = '';
        _quantity.clear();
        _purpose.clear();
        _returnDateTime.clear();
        _picked = null;
        SnackBarUtils.showSuccessSnackbar(
            context, message: response['message']);
        Navigator.pop(context);
        GoRouter.of(context).pushReplacementNamed(
            AppRouteName.categoryRouteName);
      }
    } catch (e) {
      Navigator.pop(context);
      SnackBarUtils.showErrorSnackbar(
          context, message: 'Something went wrong: $e');
    }
  }

  void deleteCatalogById(context,{required String id}) async {
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });
    final response = await HttpService.delete(
      endpoint: '${EndPoints.catalog}/$id',
    );
    if (response.containsKey('message')) {
      Navigator.pop(context);
      SnackBarUtils.showSuccessSnackbar(context, message: response['message']);
      GoRouter.of(context).pushReplacement(AppRouteName.categoryRouteName);
      notifyListeners();
    } else {
      Navigator.pop(context);
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
    }
  }


  // Dispose controllers
  // @override
  // void dispose() {
  //   _name.dispose();
  //   _description.dispose();
  //   _searchCategory.dispose();
  //   super.dispose();
  // }
}
