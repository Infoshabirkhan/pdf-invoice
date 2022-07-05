import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';


class MyExpandableCard extends StatelessWidget {
  final bool isExpand;
  final String cardTitle;
  final List<Widget> children;
  const MyExpandableCard({Key? key, required this.isExpand,required this.cardTitle, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Container(

      decoration: BoxDecoration(

        // color: Color(0xffFFFACD),

          color: Constants.cardColor,

          boxShadow: [
          BoxShadow(color: Colors.grey.withAlpha(100), blurRadius: 20)
        ]
      ),
        margin: EdgeInsets.only(top: 20.sp),
    child: ExpansionTile(
      initiallyExpanded: isExpand,

      maintainState: true,



    // backgroundColor: Colors.white,

    title: Text(cardTitle, style: TextStyle(fontSize: 18.sp),),
    children: children,

    )
    );
  }
}
