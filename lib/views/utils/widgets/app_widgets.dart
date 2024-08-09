import 'package:flutter/material.dart';

class AppWidgets{

  Widget textFormFieldView({required TextEditingController? controller,bool? enabled,String? Function(String?)? validator,required String? hintText, bool? hiddenStatus}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        validator: validator,
        obscureText: hiddenStatus ?? false,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder()
        ),
      ),
    );
  }
  Widget elevatedButtonView({required void Function()? onPressed,required Widget? child}){
    return ElevatedButton(onPressed: onPressed, child: child,style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        fixedSize: Size(250, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
    ),);
  }
  Future nextScreenPushReplacement({required context,required screen}){
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen, ),(route) => false,);
  }
  Widget sizedBoxView({Widget? child,double? width,double? height}){
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }

  getDataWidget(String text ,String data,BuildContext context, {bool? isBold}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex:2,child: Text(text,style: TextStyle(color: Theme.of(context).colorScheme.primary),)),
          Flexible(flex: 3, child: Text(data,style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: isBold !=null? FontWeight.bold: FontWeight.normal)))
        ],
      ),
    );
  }
}