import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//dark color
const grey = Color(0xff313642);
const lightGrey = Color(0xff3E4553);
const orangeAccent = Color(0xffFF7360);
const textDark = Color(0xffF0F0F0);
const deleteColor = Color(0xffCC5252);

const greenDark = Color(0xff3E533F);

//light color
const offWhite = Color(0xffF4F4F4);
const trueWhite = Color(0xffffffff);
const lightGreen = Color(0xff5CC260);
const lightText = Color(0xff585858);

TextStyle regular21 = const TextStyle(fontFamily: 'Poppins', fontSize: 21);
TextStyle bold21 = regular21.copyWith(fontWeight: FontWeight.w700);
TextStyle semibold21 = regular21.copyWith(fontWeight: FontWeight.w600);

TextStyle bold25 = bold21.copyWith(fontSize: 25);
TextStyle semibold25 = semibold21.copyWith(fontSize: 25);

TextStyle bold15 = bold21.copyWith(fontSize: 15);
TextStyle regular15 = regular21.copyWith(fontSize: 15);

TextStyle regular13 = regular21.copyWith(fontSize: 13);

// class Homepage {
//   //the color default is dark
//   static bool isDark = true;
//   static Color primaryColor = grey;
//   static Color secondaryColor = lightGrey;
//   static Color accentOrange = orangeAccent;
//   static Color accentGreen = greenDark;
//   static Color textColor = textDark;
// }
int state = Hive.box('themeData').get('state');

class AppColor {
  static Color primaryColor = (state == 0)
      ? grey
      : (state == 1)
          ? offWhite
          : (state == 2)
              ? offWhite
              : grey;
  static Color secondaryColor = (state == 0)
      ? lightGrey
      : (state == 1)
          ? trueWhite
          : (state == 2)
              ? trueWhite
              : lightGrey;
  static Color accentOrange = orangeAccent;
  static Color accentGreen = (state == 0)
      ? greenDark
      : (state == 1)
          ? lightGreen
          : (state == 2)
              ? lightGreen
              : greenDark;
  static Color textColor = (state == 0)
      ? textDark
      : (state == 1)
          ? lightText
          : (state == 2)
              ? lightText
              : textDark;

  static void switchTheme() async {
    int state = await Hive.box('themeData').get('state');
    if (state == 2) {
      primaryColor = offWhite;
      secondaryColor = trueWhite;
      accentGreen = lightGreen;
      textColor = lightText;
    } else if (state == 0) {
      primaryColor = grey;
      secondaryColor = lightGrey;
      accentGreen = greenDark;
      textColor = textDark;
    }
  }
}
