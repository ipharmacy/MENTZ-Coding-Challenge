class SystemMessage {
  SystemMessage({
    required this.type,
    required this.module,
    required this.code,
    required this.text,
  });
  late final String type;
  late final String module;
  late final int code;
  late final String text;
  
  SystemMessage.fromJson(Map<String, dynamic> json){
    type = json['type'];
    module = json['module'];
    code = json['code'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['module'] = module;
    _data['code'] = code;
    _data['text'] = text;
    return _data;
  }
}