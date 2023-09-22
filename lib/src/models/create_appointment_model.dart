import 'package:appointment_booking/src/models/doctor_list_model.dart';

class CreateAppointmentModel {
  DoctorDetailsModel? selectedDoctor;
  DateTime? bookedDate;
  String? bookedTime;
  String? bookedDuration;
  String? bookedPackage;

  CreateAppointmentModel({
    this.selectedDoctor,
    this.bookedDate,
    this.bookedTime,
    this.bookedDuration,
    this.bookedPackage,
  });
}
