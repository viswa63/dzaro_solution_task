class ATLCloudResponse {
  final int? code;
  final dynamic msg;

  ATLCloudResponse({this.code, this.msg});

  factory ATLCloudResponse.fromJson(Map<String, dynamic> json) {
    return ATLCloudResponse(
        code: json['code'] as int, msg: json['msg'] as dynamic);
  }

  factory ATLCloudResponse.fromJsons(int code, String msg) {
    return ATLCloudResponse(code: code, msg: msg);
  }
}
