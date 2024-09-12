class TodayStatus {
  String? checkinTime;
  String? checkoutTime;
  bool isCheckedIn;
  bool isCheckedOut;

  TodayStatus({
    this.checkinTime,
    this.checkoutTime,
    this.isCheckedIn = false,
    this.isCheckedOut = false,
  });

  factory TodayStatus.fromJson(Map<String, dynamic> json) {
    return TodayStatus(
      checkinTime: json['checkin_time'],
      checkoutTime: json['checkout_time'],
      isCheckedIn: json['checkin_time'] != null,
      isCheckedOut: json['checkout_time'] != null,
    );
  }
}
