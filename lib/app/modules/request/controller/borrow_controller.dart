import 'package:flutter/cupertino.dart';
import 'package:library_resource_management/app/utils/snackbar_utils.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/core/http_service.dart';

import '../../borrow/model/borrow_req_list_response_model.dart';
import '../model/borrow_ request_list_response_model.dart';

class MyBorrowRequestController extends ChangeNotifier{
  MyBorrowRequestListResponseModel _myBorrowRequest = MyBorrowRequestListResponseModel();

  MyBorrowRequestListResponseModel get myBorrowRequest => _myBorrowRequest;

  void fetchMyBorrowRequest(context) async {
    final response = await HttpService.get(endpoint: EndPoints.myBorrow);
    if(response.containsKey('error')){
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
    }else{
      _myBorrowRequest = MyBorrowRequestListResponseModel.fromJson(response);
      debugPrint('After response');
      notifyListeners();
    }
  }
}