import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_resource_management/app/modules/borrow/model/update_borrow_req_model.dart';
import 'package:library_resource_management/app/utils/snackbar_utils.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/core/http_service.dart';

import '../model/borrow_req_list_response_model.dart';

class BorrowRequestController extends ChangeNotifier{
  BorrowRequestListResponseModel _borrowRequest = BorrowRequestListResponseModel();
  TextEditingController _reqQuantity = TextEditingController();
  TextEditingController _reqStatusDescription = TextEditingController();
  int _allottedQuantity = 0;
  List<String> _reqStatusType = ['All', 'Pending', 'Approved', 'Rejected'];
  String _selectedReqStatus = 'All';
  List<String> _reqDateType = ['Today', 'Yesterday', 'This Week', 'Previous Week', 'Custom'];
  String _selectedReqDateType = 'Today';

  BorrowRequestListResponseModel get borrowRequest => _borrowRequest;
  TextEditingController get reqQuantity => _reqQuantity;
  TextEditingController get reqStatusDescription => _reqStatusDescription;
  int get allottedQuantity => _allottedQuantity;
  List<String> get reqStatusType => _reqStatusType;
  String get selectedReqStatus => _selectedReqStatus;
  List<String> get reqDateType => _reqDateType;
  String get selectedReqDateType => _selectedReqDateType;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String _from = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
  String _to = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';

  void onChangeReqStatusType(String value){
    _selectedReqStatus = value;
    notifyListeners();
  }

  void onChangeReqDateType(String value){
    final currentDate = DateTime.now();
    _selectedReqDateType = value;
    if(_selectedReqDateType == _reqDateType[0]){
      _from = formatter.format(currentDate);
      _to = formatter.format(currentDate);
    }else if(_selectedReqDateType == _reqDateType[1]) {
      _from = formatter.format(currentDate.subtract(Duration(days: 1)));
      _to = formatter.format(currentDate.subtract(Duration(days: 1)));
    } else if(_selectedReqDateType == _reqDateType[2]) {
      _from = formatter.format(currentDate.subtract(Duration(days: currentDate.weekday - 1)));
      _to = formatter.format(currentDate);
    } else if(_selectedReqDateType == _reqDateType[3]) {
      _from = formatter.format(currentDate.subtract(Duration(days: currentDate.weekday + 6)));
      _to = formatter.format(currentDate.subtract(Duration(days: currentDate.weekday - 1)));
    } else if(_selectedReqDateType == _reqDateType[4]) {
      _from = '';
      _to = '';
    }
    notifyListeners();
  }

  void onTapApplyFilter(context) {
    fetchBorrowRequests(context);
  }

  void setReqQuantityValue(int value){
    _reqQuantity.text = value.toString();
    _allottedQuantity = value;
    notifyListeners();
  }

  void setAllottedQuantity({required int value, required int index}){
    _allottedQuantity = value;
    _borrowRequest.requests![index].quantity = _allottedQuantity;
    notifyListeners();
  }

  void fetchBorrowRequests(context) async {
    final response = await HttpService.get(endpoint: '${EndPoints.borrow}?reqStatus=$_selectedReqStatus&from=$_from&to=$_to');
    if(response.containsKey('error')){
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
    }else{
      _borrowRequest = BorrowRequestListResponseModel.fromJson(response);
    }
    notifyListeners();
  }

  void approveRejectBorrowRequest(context, {required String reqStatus,required int index}) async {
    final payload = UpdateBorrowReq(
        reqStatus: reqStatus,
        quantity: _borrowRequest.requests![index].quantity!,
        reqStatusDescription: _reqStatusDescription.value.text.trim().isEmpty ? reqStatus : _reqStatusDescription.text.trim()
    );
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });
    final response = await HttpService.patch(endpoint: '${EndPoints.borrow}/${_borrowRequest.requests![index].id}', payload: payload.toJson());
    if(response.containsKey('error')){
      Navigator.pop(context);
      Navigator.pop(context);
      SnackBarUtils.showErrorSnackbar(context, message: response['error']);
    }else{
      Navigator.pop(context);
      Navigator.pop(context);
      SnackBarUtils.showSuccessSnackbar(context, message: response['message']);
      _borrowRequest.requests!.removeAt(index);
      notifyListeners();
    }
  }
}