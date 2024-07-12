class OTPRequest {
  final bool success;
  final String message;

  OTPRequest({required this.success, required this.message});

  factory OTPRequest.fromJson(Map<String, dynamic> json) {
    return OTPRequest(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
