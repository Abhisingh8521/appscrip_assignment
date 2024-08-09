import 'package:flutter/cupertino.dart';

extension Formates on String{
 String get capitalize{
    var data = split('');
    data[0] = data[0].toUpperCase();
   var finalString = data.join();
   return finalString;

  }
}

extension Responsive on BuildContext{
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}