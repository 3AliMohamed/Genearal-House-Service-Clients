// import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
// class SharedPreferencesManager {
//   static SharedPreferences? prefs;
//   static Future<void> init() async {
//     if (prefs == null) {
//       prefs = await SharedPreferences.getInstance();
//     }
//   }
//
//   static String getString(String key) {
//     return prefs?.getString(key) ?? ""; // Provide a default value, such as an empty string
//   }
//   static void setString(String key, String value) {
//
//     prefs!.setString(key, value);
//   }
//

//
//   static void remove()
//   {
//     prefs!.clear();
//   }

//
//
//
// }

class SharedPreferencesManager {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      prefs!.setString('lang', 'en');
    }
  }

  static String? getString(String? key) {
    return prefs!.getString(key!);
  }

  static void setString(String? key, String? value) {
    // prefs!.setString(key!, value!);
    if (prefs != null) {
      prefs!.setString(key!, value!);
    } else {
      print("SharedPreferences instance is null. Make sure to initialize it first.");
      // You might want to handle this situation appropriately, such as initializing prefs.
      // Alternatively, you could throw an exception or return a result indicating failure.
    }
  }

  static void clearUserSession() {
     prefs!.clear();
  }
  // static void remove() {
  //   prefs!.clear();
  // }
  static void setBool(String key, bool value) {

    prefs!.setBool(key, value);
  }
  static bool? getBool(String key) {

    return prefs?.getBool(key);
  }

  static bool? containKey(String key)
  {
    return prefs?.containsKey(key);
  }


}
