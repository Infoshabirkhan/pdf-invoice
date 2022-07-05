import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  final SignatureController controller;
  final VoidCallback clearFuntion;
  
  const SignaturePad({Key? key, required this.controller, required this.clearFuntion}) : super(key: key);

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.sp,
      margin: EdgeInsets.only(
        left: 20.sp,
        right: 20.sp,
        bottom: 20.sp,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.sp),
              child: Signature(
                controller: widget.controller,
                // backgroundColor: Colors.yellow.withOpacity(0.2),
                backgroundColor: Colors.grey.withOpacity(0.4),

              ),
            ),
          ),


          Expanded(child: TextButton.icon(label: const Text('Clear'),icon: Icon(Icons.close), onPressed: widget.clearFuntion,))
          // Expanded(
          //   flex: 1,
          // ),
        ],
      ),
    );
  }
}