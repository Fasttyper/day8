import 'package:flutter/material.dart';
import 'pereferences_service.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final _usernameController = TextEditingController();
  
  final _preferencesService = PreferencesService();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguages = Set<Languages>();
  var _isEmployed = true;

  void _populateFields() async{
    final settings = await _preferencesService.getSettings();

    setState(() {
      _usernameController.text = settings.username;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.languages;
      _isEmployed = _isEmployed;
    });
  }

  @override
  
  void initState(){
    super.initState();
    _populateFields();
  }
  
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile settings"),
        ),
        body: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              ListTile(
                title: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "Username"),
                ),
              ),
              _radioListTile("Female", Gender.FEMALE),
              _radioListTile("Male", Gender.MALE),
              _radioListTile("Other", Gender.OTHER),
              _checkboxTile("English", Languages.ENGLISH),
              _checkboxTile("Russian", Languages.RUSSIAN),
              _checkboxTile("Uzbek", Languages.UZBEK),
              _checkboxTile("Japan", Languages.JAPAN),
              SwitchListTile(
                title: Text("Is Employed"),
                value: _isEmployed,
                onChanged: (newValue) => setState(() => _isEmployed = newValue),
              ),
              SizedBox(
                width: 200.0,
                height: 80.0,
                child: TextButton(
                  child: Text("Save preferences"),
                  onPressed: _saveSettings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
      username: _usernameController.text,
      gender: _selectedGender,
      languages: _selectedLanguages,
      isEmployed: _isEmployed,
    );

    print(newSettings);

    _preferencesService.saveSettings(newSettings);
    
  }

  Widget _radioListTile(String _title, Gender value) {
    return RadioListTile(
      title: Text(_title),
      value: value,
      groupValue: _selectedGender,
      onChanged: (newValue) => setState(() => _selectedGender = newValue),
    );
  }

  Widget _checkboxTile(String _title, Languages _value) {
    return CheckboxListTile(
      title: Text(_title),
      value: _selectedLanguages.contains(_value),
      onChanged: (_) {
        setState(() {
          _selectedLanguages.contains(_value)
              ? _selectedLanguages.remove(_value)
              : _selectedLanguages.add(_value);
        });
      },
    );
  }
}
