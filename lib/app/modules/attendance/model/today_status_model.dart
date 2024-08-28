class TodayStatus {
  final String? checkinTime;
  final String? checkoutTime;
   bool isCheckedIn;
   bool isCheckedOut;

  TodayStatus({
    this.checkinTime,
    this.checkoutTime,
    this.isCheckedIn = false,
    this.isCheckedOut = false,
  });
}
