class Parent {
  Parent({
    required this.id,
    required this.name,
    required this.type,
  });
  late final String id;
  late final String name;
  late final String type;
  
  Parent.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    return _data;
  }
}
