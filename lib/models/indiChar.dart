class IndiChar {
  String name;
  String patronus;
  String bloodStatus;
  String house;
  String role;
  String school;
  String alias;
  String wand;
  String boggart;

  bool ministryOfMagic;
  bool orderOfThePhoenix;
  bool dumbledoresArmy;
  bool deathEater;

  String species;
  IndiChar(
      this.bloodStatus,
      this.house,
      this.name,
      this.patronus,
      this.alias,
      this.boggart,
      this.deathEater,
      this.dumbledoresArmy,
      this.ministryOfMagic,
      this.orderOfThePhoenix,
      this.role,
      this.school,
      this.species,
      this.wand);
  IndiChar.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    house = json['house'] != null ? json['house'] : 'unknown';
    bloodStatus = json['bloodStatus'] != null ? json['bloodStatus'] : 'unknown';
    patronus = json['patronus'] != null ? json['patronus'] : 'unknown';
    role = json['role'] != null ? json['role'] : 'unknown';
    school = json['school'] != null ? json['school'] : 'unknown';
    alias = json['alias'] != null ? json['alias'] : 'unknown';
    wand = json['wand'] != null ? json['wand'] : 'unknown';
    boggart = json['boggart'] != null ? json['boggart'] : 'unknown';
    ministryOfMagic =
        json['ministryOfMagic'] != null ? json['ministryOfMagic'] : false;
    orderOfThePhoenix =
        json['orderOfThePhoenix'] != null ? json['orderOfThePhoenix'] : false;
    dumbledoresArmy =
        json['dumbledoresArmy'] != null ? json['dumbledoresArmy'] : false;
    deathEater = json['deathEater'] != null ? json['deathEater'] : false;
    species = json['species'] != null ? json['species'] : 'unknown';
  }
}
