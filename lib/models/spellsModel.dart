class Spells {
  String spell;
  String type;
  String effect;

  Spells(this.effect, this.spell, this.type);
  Spells.fromJson(Map<String, dynamic> json) {
    spell = json['spell'];
    type = json['type'];
    effect = json['effect'];
  }
}
