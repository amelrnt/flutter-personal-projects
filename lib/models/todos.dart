class Todos {
  Todos({
    required this.id,
    required this.name,
    required this.description,
    required this.updated_at,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String updated_at;

  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['updated_at'] = updated_at;
    return data;
  }
}
