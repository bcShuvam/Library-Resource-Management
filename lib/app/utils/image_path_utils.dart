import 'package:library_resource_management/core/end_points.dart';

class ImagePathUtils{
  static String getRelativePath(String fullPath) {
    final uploadsIndex = fullPath.indexOf('/uploads');
    if (uploadsIndex == -1) return fullPath; // fallback if not found
    return '${EndPoints.baseUrl}${fullPath.substring(uploadsIndex)}';
  }
}

