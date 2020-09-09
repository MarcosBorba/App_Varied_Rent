import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var resultSearch = await json.decode(prefs.getString(key));
    return resultSearch;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  checkKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  getKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}
