enum Gender {FEMALE, MALE, OTHER,}
enum Languages {ENGLISH, RUSSIAN, UZBEK, JAPAN,}

class Settings{
  final String username;
  final Gender gender;
  final Set<Languages> languages;
  final bool isEmployed;
  
  Settings({this.username, this.gender, this.languages, this.isEmployed});
}