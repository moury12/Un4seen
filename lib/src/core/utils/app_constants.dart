import 'package:flutter/material.dart';

// ── Radius ──────────────────────────────────────────────
const double appRadius   = 12.0;
const double appRadius16 = 16.0;

// ── Spacing widgets ──────────────────────────────────────
const SizedBox space2H  = SizedBox(height: 2);
const SizedBox space4H  = SizedBox(height: 4);
const SizedBox space8H  = SizedBox(height: 8);
const SizedBox space12H = SizedBox(height: 12);
const SizedBox space16H = SizedBox(height: 16);
const SizedBox space24H = SizedBox(height: 24);

const SizedBox space4W  = SizedBox(width: 4);
const SizedBox space8W  = SizedBox(width: 8);
const SizedBox space16W = SizedBox(width: 16);

// ── Padding helpers ──────────────────────────────────────
class AppPadding {
  AppPadding._();

  static EdgeInsets getPadding8(BuildContext ctx)    => const EdgeInsets.all(8);
  static EdgeInsets getPadding12(BuildContext ctx)   => const EdgeInsets.all(12);
  static EdgeInsets getPadding16(BuildContext ctx)   => const EdgeInsets.all(16);
  static EdgeInsets getPadding24(BuildContext ctx)   => const EdgeInsets.all(24);
  static EdgeInsets getPadding12H(BuildContext ctx)  => const EdgeInsets.symmetric(horizontal: 12);
  static EdgeInsets getPaddingH12V4(BuildContext ctx)=> const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
}
