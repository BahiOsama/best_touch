class Datum {
  int? id;
  String? title;
  String? description;
  String? image;
  bool? isWasherExists;
  String? washer;
  int? washerId;

  Datum({
    this.id,
    this.title,
    this.description,
    this.image,
    this.isWasherExists,
    this.washer,
    this.washerId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        isWasherExists: json['isWasherExists'] as bool?,
        washer: json['washer'] as String?,
        washerId: json['washer_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'isWasherExists': isWasherExists,
        'washer': washer,
        'washer_id': washerId,
      };
}
