class PersonInfo {
  String name = '';
  String height = '';
  String mass = '';
  String birthYear = '';
  String gender = '';
  String hairColor = '';

  PersonInfo(this.name, this.height, this.mass, this.birthYear, this.gender,
      this.hairColor);

  PersonInfo.empty() {
    name = '';
    height = '';
    mass = '';
    birthYear = '';
    gender = '';
    hairColor = '';
  }
}
