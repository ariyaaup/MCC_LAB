class Wngine {
  String name;
  int price;
  String rarityGUN;
  int baseATK;
  String baseAdvStat;
  String description;
  int typeID;
  int level;
  String gun_image;
  int wNgineID;

  Wngine({
    required this.name,
    required this.price,
    required this.rarityGUN,
    required this.baseATK,
    required this.baseAdvStat,
    required this.description,
    required this.typeID,
    required this.level,
    required this.gun_image,
    required this.wNgineID,
  });

  factory Wngine.fromJson(Map<String, dynamic> json) => Wngine(
        name: json["name"].toString(),
        price: json["price"] as int,
        rarityGUN: json["rarityGUN"].toString(),
        baseATK: json["baseATK"] as int,
        baseAdvStat: json["baseAdvStat"].toString(),
        description: json["description"].toString(),
        typeID: json["typeID"] as int,
        level: json["level"] as int,
        gun_image: json["gun_image"].toString(),
        wNgineID: json["wNgineID"] as int,
      );
}
