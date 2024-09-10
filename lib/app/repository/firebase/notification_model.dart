class NotificationModel {
  String id;
  String notificationAbout;
  String notificationMessage;
  DateTime notificationTime;
  NotificationModel({
    required this.id,
    required this.notificationAbout,
    required this.notificationMessage,
    required this.notificationTime,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notificationAbout': notificationAbout,
      'notificationMessage': notificationMessage,
      'notificationTime': notificationTime.toIso8601String(),
    };
  }
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      notificationAbout: json['notificationAbout'],
      notificationMessage: json['notificationMessage'],
      notificationTime: DateTime.parse(json['notificationTime']),
    );
  }
}


// List<NotificationModel> notificationsList = [
//   // NotificationModel(
//   //   id: '1',
//   //   notificationAbout: 'TADA Expense Claim fdslfhkjdshfkjdshfkjdshfkjdshfdskjfhdsk',
//   //   notificationMessage: 'Your TADA expense claim for May has been approved.dsfjfjlkdsjfdskfjsdlflsdfjsldkfjldsfjsdlkf',
//   //   notificationTime: DateTime.now().subtract(const Duration(seconds: 10)),
//   // ),
// ];