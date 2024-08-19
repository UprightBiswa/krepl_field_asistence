class ActivityMaster {
  final int id;
  final String promotionalActivity;
  final String masterLink;
  final String form;
  final String r1;
  final String r2;
  final String r3;

  ActivityMaster({
    required this.id,
    required this.promotionalActivity,
    required this.masterLink,
    required this.form,
    required this.r1,
    required this.r2,
    required this.r3,
  });

  // Factory constructor to create an ActivityMaster instance from JSON
  factory ActivityMaster.fromJson(Map<String, dynamic> json) {
    return ActivityMaster(
      id: json['id'],
      promotionalActivity: json['promotional_activity'],
      masterLink: json['master_link'],
      form: json['form'],
      r1: json['r1'] ?? '',
      r2: json['r2'] ?? '',
      r3: json['r3'] ?? '',
    );
  }

  // Method to convert ActivityMaster instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'promotional_activity': promotionalActivity,
      'master_link': masterLink,
      'form': form,
      'r1': r1,
      'r2': r2,
      'r3': r3,
    };
  }
}
