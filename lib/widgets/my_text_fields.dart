import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFields extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final String label;
  final String hint;
  const MyTextFields({Key? key,  required this.inputType,required this.controller, required this.label, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 Container(
      margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 15.sp),
      child:  TextFormField(

        keyboardType: inputType,
        validator: (value){
          if( value == null || value == '' || value.isEmpty){
            return 'Data is required';
          }else{
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(

          border: const OutlineInputBorder(),
            fillColor: Colors.grey.shade300,
            filled: true,
            label: Text(label),
            hintText: hint
        ),
      ),
    );
  }
}
