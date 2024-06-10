class BaseResponseModel {
  int? status;
  String? msg;
  dynamic data;

  BaseResponseModel({this.status, this.msg, this.data});
  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    return data;
  }
}
