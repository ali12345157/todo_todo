import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class MyThemeData{
  static final ThemeData LightTheme =ThemeData(primaryColor: AppColor.primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: AppColor.primaryColor,unselectedItemColor:AppColor.graycolor,backgroundColor: Colors.transparent,elevation: 0 ),
      textTheme: TextTheme(titleLarge: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold,color: AppColor.whitecolor,),titleMedium: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold,color: AppColor.blackcolor,)),
      scaffoldBackgroundColor: AppColor.background,
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor:AppColor.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35),
              side: BorderSide(color: AppColor.whitecolor,width: 5)))
      ,bottomSheetTheme: BottomSheetThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35),
          side: BorderSide(color: AppColor.whitecolor,width: 5))));




}