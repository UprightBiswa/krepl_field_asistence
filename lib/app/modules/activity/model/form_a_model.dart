class FormAModel {
  String formName; // Form name or identifier
  String promotionalActivitiesType;
  String partyType;
  String mobileNumber;
  String farmerVillageDoctorName;
  String season;
  String crop;
  String cropStage;
  String product;
  String pest;
  int totalNumberFarmerVillageDoctor;
  double expense; // Assuming expense is a numeric field
  bool photoRequired;
  bool jioLocationTickRequired;
  String updateMobileNumber; // Assuming it's a string if it involves updating a mobile number
  String remark;

  FormAModel({
    required this.formName,
    required this.promotionalActivitiesType,
    required this.partyType,
    required this.mobileNumber,
    required this.farmerVillageDoctorName,
    required this.season,
    required this.crop,
    required this.cropStage,
    required this.product,
    required this.pest,
    required this.totalNumberFarmerVillageDoctor,
    required this.expense,
    required this.photoRequired,
    required this.jioLocationTickRequired,
    required this.updateMobileNumber,
    required this.remark,
  });
}
