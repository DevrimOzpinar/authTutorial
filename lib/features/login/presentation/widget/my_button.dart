import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButtonDedik extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  const MyButtonDedik({Key? key, this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25.r),
        margin: EdgeInsets.symmetric(horizontal: 25.r),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
