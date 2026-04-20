import 'package:flutter_screenutil/flutter_screenutil.dart';

const double kSmallMobileBreakpoint = 380.0;
const double kMobileBreakpoint = 450.0;

extension AdaptiveExtension on num {
  double get a {
    try {
      if (ScreenUtil().screenWidth == 0) return toDouble();
    } catch (_) {
      return toDouble();
    }

    final screenWidth = ScreenUtil().screenWidth;

    if (screenWidth <= kSmallMobileBreakpoint) {
      return w * 0.9;
    }

    if (screenWidth <= kMobileBreakpoint) {
      return w;
    }

    return toDouble();
  }

  double get sA {
    try {
      if (ScreenUtil().screenWidth == 0) return toDouble();
    } catch (_) {
      return toDouble();
    }

    final screenWidth = ScreenUtil().screenWidth;

    if (screenWidth <= kSmallMobileBreakpoint) {
      return sp * 0.85;
    }

    if (screenWidth <= kMobileBreakpoint) {
      return sp;
    }

    return toDouble();
  }
}
