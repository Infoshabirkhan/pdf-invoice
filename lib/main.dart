import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf_invoice/screens/data_input_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Invoice PDF',
        theme: ThemeData(

          appBarTheme: AppBarTheme(
            color: Colors.greenAccent,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 22.sp)
          ),
          primarySwatch: Colors.blue,
        ),
        home: const DataInputScreen(),
      ),
      designSize: const Size(360, 800),
    );
  }
}
