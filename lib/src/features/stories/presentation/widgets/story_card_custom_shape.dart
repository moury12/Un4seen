import 'package:flutter/material.dart';

/// ১. এই উইজেটটি আপনি আপনার গ্রিড বা লিস্টে ব্যবহার করবেন
class GenericSlantedCard extends StatelessWidget {
  final Widget child;           // কার্ডের ভেতরে যা দেখাতে চান (Image, Column, ইত্যাদি)
  final bool isLeft;            // বাম পাশের না কি ডান পাশের কার্ড
  final double slantHeight;     // কতটুকু বাঁকা হবে
  final double borderRadius;    // কোণাগুলো কতটুকু গোল হবে
  final Color borderColor;      // বর্ডারের রঙ
  final double borderWidth;     // বর্ডারের পুরুত্ব

  const GenericSlantedCard({
    super.key,
    required this.child,
    this.isLeft = true,
    this.slantHeight = 40.0,
    this.borderRadius = 20.0,
    this.borderColor = Colors.blue,
    this.borderWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        // border: Border.all(color: borderColor, width: borderWidth),
        // শ্যাডো দিতে চাইলে এখানে যোগ করতে পারেন
      ),
      child: ClipPath(
        clipper: SlantedShapeClipper(
          isLeft: isLeft,
          slantHeight: slantHeight,
          radius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}

/// ২. এই ক্লাসটি শেপ তৈরি করার মেইন লজিক হ্যান্ডেল করে
class SlantedShapeClipper extends CustomClipper<Path> {
  final bool isLeft;
  final double slantHeight;
  final double radius;

  SlantedShapeClipper({
    required this.isLeft,
    required this.slantHeight,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    // উপরের বাম কোণা থেকে শুরু
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    
    // উপরের ডান কোণা
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    if (isLeft) {
      // বাম পাশের কার্ডের জন্য: ডান দিক ছোট হবে
      path.lineTo(size.width, size.height - slantHeight - radius);
      path.quadraticBezierTo(size.width, size.height - slantHeight, size.width - radius, size.height - slantHeight);
      path.lineTo(radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    } else {
      // ডান পাশের কার্ডের জন্য: বাম দিক ছোট হবে
      path.lineTo(size.width, size.height - radius);
      path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
      path.lineTo(radius, size.height - slantHeight);
      path.quadraticBezierTo(0, size.height - slantHeight, 0, size.height - slantHeight - radius);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}