class BookingConfirmationModel {
  String doctorName;
  DateTime? appointmentDate;
  String appointmentTime;
  String location;
  String appointmentPackage;

  BookingConfirmationModel({
    this.doctorName = '',
    this.appointmentDate,
    this.appointmentTime = '',
    this.location = '',
    this.appointmentPackage = '',
  });

  factory BookingConfirmationModel.fromMap(Map<String, dynamic> json) =>
      BookingConfirmationModel(
        doctorName: json["doctor_name"] ?? '',
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        appointmentTime: json["appointment_time"] ?? '',
        location: json["location"] ?? '',
        appointmentPackage: json["appointment_package"] ?? '',
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "doctor_name": doctorName,
        "appointment_date":
            "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
        "appointment_time": appointmentTime,
        "location": location,
        "appointment_package": appointmentPackage,
      };
}
