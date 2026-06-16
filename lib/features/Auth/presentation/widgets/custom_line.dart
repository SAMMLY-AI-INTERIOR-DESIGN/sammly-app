import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customline extends StatelessWidget {
  final String text;

  const Customline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            text,
            style: TextStyle(fontSize: 15.1.sp, color: Colors.black),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
