class DriverProfileResponseModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? photo;
  final String? vehicleNumber;

  DriverProfileResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.photo,
    this.vehicleNumber,
  });

  factory DriverProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final driver = json['driver'] as Map<String, dynamic>? ?? {};
    return DriverProfileResponseModel(
      id: driver['_id'] as String?,
      firstName: driver['firstName'] as String?,
      lastName: driver['lastName'] as String?,
      phone: driver['phone'] as String?,
      email: driver['email'] as String?,
      photo: driver['photo'] as String?,
      vehicleNumber: driver['vehicleNumber'] as String?,
    );
  }
}
