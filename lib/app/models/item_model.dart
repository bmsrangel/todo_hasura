class ItemModel {
  int id;
  String description;
  bool completed;

  ItemModel({
    this.id,
    this.description,
    this.completed,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        description: json["description"],
        completed: json["completed"],
      );

  static List<ItemModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ItemModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "completed": completed,
      };
}
