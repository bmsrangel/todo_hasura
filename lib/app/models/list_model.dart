import 'dart:convert';

import 'package:todo_hasura/app/models/item_model.dart';

ListModel listModelFromJson(String str) => ListModel.fromJson(json.decode(str));

String listModelToJson(ListModel data) => json.encode(data.toJson());

class ListModel {
  int id;
  String name;

  ListModel({this.id, this.name});

  factory ListModel.fromJson(Map<String, dynamic> json) =>
      ListModel(id: json["id"], name: json["name"]);

  static List<ListModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ListModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ListElement {
  int id;
  String name;
  List<ItemModel> items;

  ListElement({
    this.id,
    this.name,
    this.items,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        items: List<ItemModel>.from(json["items"].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
