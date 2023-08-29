class Properties {
  Properties({
    required this.stopId,
  });
  late final String stopId;
  
  Properties.fromJson(Map<String, dynamic> json){
    stopId = json['stopId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stopId'] = stopId;
    return _data;
  }
}