import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeUtils{
  static String convertToLocalTime(String utcDateTimeString, {String format = 'dd MMM yyyy, hh:mm a'}) {
    // debugPrint('Server Time = $utcDateTimeString');
    // Parse the UTC string
    DateTime utcDateTime = DateTime.parse(utcDateTimeString);

    // Convert to local time zone
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the local DateTime as desired
    final formatter = DateFormat(format);

    return formatter.format(localDateTime);
  }

  static String timeAgo(DateTime pastTime) {
    final now = DateTime.now();
    final difference = now.difference(pastTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
