class ProjectModel {
  final int id;
  final int agencyId;
  final String name;
  final String location;
  final int price;
  final String? imageUrl;
  final String? description;
  final String? status;

  ProjectModel({
    required this.id,
    required this.agencyId,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.description,
    this.status,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] as int,
      agencyId: map['agency_id'] as int,
      name: map['name'] as String,
      location: map['location'] as String,
      price: map['price'] as int,
      imageUrl: map['image_url'],
      description: map['description'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'agency_id': agencyId,
      'name': name,
      'location': location,
      'price': price,
      'image_url': imageUrl,
      'description': description,
      'status': status,
    };
  }
}
