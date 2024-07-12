class VerifyOTPResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  VerifyOTPResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOTPResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? {},
    );
  }
}
