import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

class PreferencesService {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString("username", settings.username);
    await preferences.setInt("gender", settings.gender.index);
    await preferences.setBool("isEmployed", settings.isEmployed);
    
    await preferences.setStringList(
      "languages",
      settings.languages.map(
        (lang) => lang.index.toString(),
      ),
    );

    print("Preferences saved!");
  }
}
