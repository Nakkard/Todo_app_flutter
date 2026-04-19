import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  runZonedGuarded(
    () {
      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stackTrace) {
      debugPrint('GLOBAL ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
