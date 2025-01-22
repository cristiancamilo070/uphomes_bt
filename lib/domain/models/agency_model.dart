class AgencyModel {
  final int id;
  final String name;
  final String themeColor;
  final String logo;

  AgencyModel({
    required this.id,
    required this.name,
    required this.themeColor,
    required this.logo,
  });

  factory AgencyModel.fromMap(Map<String, dynamic> map) {
    return AgencyModel(
      id: map['id'] as int,
      name: map['name'] as String,
      themeColor: map['theme_color'] as String,
      logo: map['logo'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'theme_color': themeColor,
      'logo': logo,
    };
  }
}
