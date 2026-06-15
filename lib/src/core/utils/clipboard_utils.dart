import 'package:flutter/services.dart';
import '../widgets/custom_snackbar.dart';

class ClipboardUtils {
  ClipboardUtils._();

  static Future<void> copyText(String text) async {
    if (text.isEmpty) return;
    
    await Clipboard.setData(ClipboardData(text: text));
    
    // Using your existing custom snackbar logic
    CustomSnackbar.showSuccess("Copied to clipboard!");
  }
}