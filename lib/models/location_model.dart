import 'package:challenge/models/parent_model.dart';
import 'package:challenge/models/properties_model.dart';

class Location {
  late final String id;
  late final bool? isGlobalId;
  late final String name;
  late final String disassembledName;
  late final List<dynamic> coord;
  late final String type;
  late final int matchQuality;
  late final bool isBest;
  late final List<int>? productClasses;
  late final Parent parent;
  late final Properties? properties;

  Location({
    required this.id,
    this.isGlobalId,
    required this.name,
    required this.disassembledName,
    required this.coord,
    required this.type,
    required this.matchQuality,
    required this.isBest,
    this.productClasses,
    required this.parent,
    this.properties,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isGlobalId = json['isGlobalId'];
    name = json['name'];
    disassembledName = json['disassembledName'];
    coord = List.castFrom<dynamic, dynamic>(json['coord']);
    type = json['type'];
    matchQuality = json['matchQuality'];
    isBest = json['isBest'];
    if (json['productClasses'] != null) {
      productClasses = List.castFrom<dynamic, int>(json['productClasses']);
    }
    parent = Parent.fromJson(json['parent']);
    if (json['properties'] != null) {
      properties = Properties.fromJson(json['properties']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['isGlobalId'] = isGlobalId;
    _data['name'] = name;
    _data['disassembledName'] = disassembledName;
    _data['coord'] = coord;
    _data['type'] = type;
    _data['matchQuality'] = matchQuality;
    _data['isBest'] = isBest;
    _data['productClasses'] = productClasses;
    _data['parent'] = parent.toJson();
    _data['properties'] = properties?.toJson();
    return _data;
  }
}
