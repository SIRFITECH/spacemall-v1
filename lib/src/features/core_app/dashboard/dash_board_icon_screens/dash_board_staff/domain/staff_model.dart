class StaffModel {
  String staffId;
  String staffName;
  DateTime payDate;
  String phone;

  StaffModel({
    required this.staffId,
    required this.staffName,
    required this.payDate,
    required this.phone,
  });

  // populated from map, that is serializing the staffs object from server
  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      staffId: map['staffId'] ?? '',
      staffName: map['staffName'] ?? '',
      payDate: map['payDate'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  // populated to map, that is serializing the staffs object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "staffName": staffName,
      "staffId": staffId,
      "payDate": payDate,
      "phone": phone,
    };
  }
}
