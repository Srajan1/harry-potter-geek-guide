class Char {
  String name;
  String house;
  String bloodStatus;
  String patronus;
  Char(this.bloodStatus, this.house, this.name, this.patronus);
  Char.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    house = json['house'] != null ? json['house'] : 'unknown';
    bloodStatus = json['bloodStatus'] != null ? json['bloodStatus'] : 'unknown';
    patronus = json['patronus'] != null ? json['patronus'] : 'unknown';
  }
}
