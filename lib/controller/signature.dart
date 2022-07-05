


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class MySignature{

   getSignature (){

    SignatureController _controller = SignatureController(
      penStrokeWidth: 1,
      penColor: Colors.red,
      exportBackgroundColor: Colors.blue,
      onDrawStart: () => print('onDrawStart called!'),
      onDrawEnd: () => print('onDrawEnd called!'),
    );

    var signature =  _controller.toPngBytes();

    _controller.dispose();
    return signature;
  }


   static Uint8List signature = Uint8List(0);

}