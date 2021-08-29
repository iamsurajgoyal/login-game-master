import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";      //The shared preference is used because we want the data of the user having the conversation with the other users 
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";         //gets saved in the phone and even when the user is offline the user should be able to see all the chats
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
                                                      //saving data to shared preference [It's use is that if user has made a login and closed the app 
                                                     //then even in offline mode he can see the data and also he should stay logged in after closing the app
                                                    //once he made the login to the app
  static Future<bool> saveUserLoggedInSharedPreference(              //static is used so that we can actually use the function anywhere 
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {         //Future is used because the particular thing happening will take some time
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

    static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }
}