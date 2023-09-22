import 'package:appointment_booking/src/models/create_appointment_model.dart';
import 'package:appointment_booking/src/models/doctor_list_model.dart';
import 'package:appointment_booking/src/providers/api_provider.dart';
import 'package:appointment_booking/src/screens/book_appointment/book_appointment_screen.dart';
import 'package:flutter/material.dart';

class DoctorDashBoardProvider extends ChangeNotifier {
  bool isLoading = true;
  List<DoctorDetailsModel> doctorList = <DoctorDetailsModel>[];
  CreateAppointmentModel createAppointmentModel = CreateAppointmentModel();

  void onBookClickEvent(BuildContext context, DoctorDetailsModel doctor) {
    createAppointmentModel.selectedDoctor = doctor;
    BookAppointmentScreen.openScreen(context);
  }

  Future<void> fetchDoctorList({bool isBuildMethodAlreadyCalled = true}) async {
    isLoading = true;
    if (isBuildMethodAlreadyCalled) {
      notifyListeners();
    }
    final List<DoctorDetailsModel>? responseData =
        await ApiProvider().fetchDoctorsApi();
    if (responseData != null) {
      doctorList = List<DoctorDetailsModel>.of(responseData);
    }
    isLoading = false;
    notifyListeners();
  }
}
