import 'package:challenge/models/location_model.dart';
import 'package:challenge/models/system_message_model.dart';

class ResponseModel {
  ResponseModel({
    required this.version,
    required this.systemMessages,
    required this.locations,
  });
  late final String version;
  late final List<SystemMessage> systemMessages;
  late final List<Location> locations;
  
  ResponseModel.fromJson(Map<String, dynamic> json){
    version = json['version'];
    systemMessages = List.from(json['systemMessages']).map((e)=>SystemMessage.fromJson(e)).toList();
    locations = List.from(json['locations']).map((e)=>Location.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['systemMessages'] = systemMessages.map((e)=>e.toJson()).toList();
    _data['locations'] = locations.map((e)=>e.toJson()).toList();
    return _data;
  }
}