class ErrorResponse {
  String? status;
  String? code;
  String? message;

  ErrorResponse({this.status, this.code, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    code = json['code'] ?? "";
    message = json['message'] ?? "";
  }
}
