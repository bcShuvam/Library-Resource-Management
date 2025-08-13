import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_resource_management/app/modules/profile/model/profile_response_model.dart';
import 'package:library_resource_management/core/end_points.dart';
import 'package:library_resource_management/core/http_service.dart';
import 'package:library_resource_management/firebase_msg.dart';

import '../../../consts/string_consts.dart';

class ProfileController extends ChangeNotifier{
  String _fullName = '';
  String _email = '';
  String _photoUrl = '';
  String _googleId = '';
  String _role = '';
  String _fbToken = '';
  ProfileResponseModel profile = ProfileResponseModel();
  bool _isLoading = false;

  String get fullName => _fullName;
  String get email => _email;
  String get photoUrl => _photoUrl;
  String get googleId => _googleId;
  String get role => _role;
  String get fbToken => _fbToken;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile() async {
    _isLoading = false;
    final data = await HttpService.get(endpoint: EndPoints.profile);
    debugPrint('data = $data');
    ProfileResponseModel profile = ProfileResponseModel.fromJson(data);
    _fullName = profile.fullName!;
    _email = profile.email!;
    _photoUrl = profile.photoUrl!;
    _googleId = profile.googleId!;
    _role = profile.role!;
    _fbToken = profile.fbToken ?? '';
    debugPrint('Controller Profile = ${profile.toJson()}');
    _isLoading = false;
    debugPrint('_isLoading = $_isLoading');
    debugPrint('Profile Token = $fbToken');
    notifyListeners();
  }

}