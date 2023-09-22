class AppointmentDetailsModel {
  String bookingId;
  String doctorName;
  String location;
  DateTime? appointmentDate;
  String appointmentTime;

  AppointmentDetailsModel({
    this.bookingId = '',
    this.doctorName = '',
    this.location = '',
    this.appointmentDate,
    this.appointmentTime = '',
  });

  factory AppointmentDetailsModel.fromMap(Map<String, dynamic> json) =>
      AppointmentDetailsModel(
        bookingId: json["booking_id"] ?? '',
        doctorName: json["doctor_name"] ?? '',
        location: json["location"] ?? '',
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        appointmentTime: json["appointment_time"] ?? '',
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "booking_id": bookingId,
        "doctor_name": doctorName,
        "location": location,
        "appointment_date":
            "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
        "appointment_time": appointmentTime,
      };
}
