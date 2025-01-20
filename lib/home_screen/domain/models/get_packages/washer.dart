class Washer {
  int? id;
  String? name;
  String? image;

  Washer({this.id, this.name, this.image});

  factory Washer.fromJson(Map<String, dynamic> json) => Washer(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
