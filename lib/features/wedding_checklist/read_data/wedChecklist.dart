import 'dart:convert';

WedChecklist wedChecklistFromJson(String str) => WedChecklist.fromJson(json.decode(str));

String wedChecklistToJson(WedChecklist data) => json.encode(data.toJson());

class WedChecklist {
  String id;
  String title;
  bool isChecked;

  WedChecklist({
    required this.id,
    required this.title,
    required this.isChecked,
  });

  factory WedChecklist.fromJson(Map<String, dynamic> json) => WedChecklist(
    id: json["id"],
    title: json["title"],
    isChecked: json["isChecked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "isChecked": isChecked,
  };
}