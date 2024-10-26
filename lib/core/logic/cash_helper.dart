import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static late SharedPreferences _prefs;
  static Future <void>  init() async{
    _prefs = await SharedPreferences.getInstance();
  }
  static setIsFirstTime()async{
    await _prefs.setBool("isFirstTime", false);
  }
  static bool get isFirstTime {
    return _prefs.getBool("isFirstTime")??true;
  }
  static String get name{
   return _prefs.getString("name")??"";
  }
  static String get token{
   return _prefs.getString("token")??"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9hcGlcL2xvZ2luIiwiaWF0IjoxNzE3MjI5ODYzLCJleHAiOjE3NDg3NjU4NjMsIm5iZiI6MTcxNzIyOTg2MywianRpIjoiWGtQMUV6S045MGFaWlU5MCIsInN1YiI6MzkwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.DX1toxwGm9W-7CTJB2IAo8V0tLmK2Dwec3n9CyF3plw";
  }
  static int get password{
    return _prefs.getInt("password")??0;
  }
  static get logout{
    return _prefs.remove("isFirstTime");
  }
  static Future setCount(int value)async{
    await _prefs.setInt("count", value);
  }
  static int get count{
    return _prefs.getInt("count")??0;
  }
  }