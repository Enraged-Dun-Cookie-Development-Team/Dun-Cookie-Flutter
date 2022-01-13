import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DunPreferences {
  late final Future<SharedPreferences> prefs;

  DunPreferences() {
    initSharedPreferences();
  }

  initSharedPreferences() {
    prefs = SharedPreferences.getInstance();
  }

  saveBool({key, value}) async {
    await prefs.then((_) => _.setBool(key, value));
  }

  saveDouble({key, value}) async {
    return await prefs.then((_) => _.setDouble(key, value));
  }

  saveInt({key, value}) async {
    return await prefs.then((_) => _.setInt(key, value));
  }

  saveString({key, value}) async {
    return await prefs.then((_) => _.setString(key, value));
  }

  saveStringList({key, value}) async {
    return await prefs.then((_) => _.setStringList(key, value));
  }

  getBool({key, value}) async {
    return await prefs.then((_) => _.getBool(key) ?? false);
  }

  getDouble({key, value}) async {
    return await prefs.then((_) => _.getDouble(key) ?? 0.0);
  }

  getInt({key, value}) async {
    return await prefs.then((_) => _.getInt(key) ?? 0);
  }

  getString({key, value}) async {
    return await prefs.then((_) => _.getString(key) ?? "");
  }

  getStringList({key, value}) async {
    return await prefs.then((_) => _.getStringList(key) ?? []);
  }
}