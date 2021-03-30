import 'package:flutter/material.dart';
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
      settings.languages
          .map(
            (lang) => lang.index.toString(),
          )
          .toList(),
    );

    print("Preferences saved!");
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final username = preferences.getString("username");
    final isEmployed = preferences.getBool("isEmployed");
    final gender = Gender.values[preferences.getInt("gender") ?? 0];

    final languagesIndicies = 
      preferences.getStringList("languages");
    
    final languages = languagesIndicies
        .map(
          (stringIndex) => Languages.values[int.parse(stringIndex)],
        )
        .toSet();

    return Settings(
      username: username,
      gender: gender,
      languages: languages,
      isEmployed: isEmployed,
    );
  }
}
