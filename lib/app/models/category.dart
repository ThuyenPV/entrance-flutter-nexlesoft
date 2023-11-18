class Category {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  Category({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "name": name,
      };
}
