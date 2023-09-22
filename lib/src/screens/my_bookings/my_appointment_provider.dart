import 'package:appointment_booking/src/models/appointment_details_model.dart';
import 'package:appointment_booking/src/providers/api_provider.dart';
import 'package:flutter/material.dart';

class MyAppointmentProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isSearching = false;
  List<AppointmentDetailsModel> _appointmentList = <AppointmentDetailsModel>[];
  List<AppointmentDetailsModel> filteredList = <AppointmentDetailsModel>[];

  void onSearchIconClickEvent() {
    isSearching = true;
    notifyListeners();
  }

  void onSearchDoctor(String val) {
    if (val.isEmpty) {
      filteredList = List<AppointmentDetailsModel>.of(_appointmentList);
    } else {
      filteredList = _appointmentList
          .where((AppointmentDetailsModel element) =>
              element.doctorName.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void onSearchCloseEvent() {
    isSearching = false;
    filteredList = List<AppointmentDetailsModel>.of(_appointmentList);
    notifyListeners();
  }

  Future<void> fetchAppointmentList(
      {bool isBuildMethodAlreadyCalled = true}) async {
    isLoading = true;
    if (isBuildMethodAlreadyCalled) {
      notifyListeners();
    }
    final List<AppointmentDetailsModel>? responseData =
        await ApiProvider().fetchAppointmentList();
    if (responseData != null) {
      _appointmentList = List<AppointmentDetailsModel>.of(responseData);
      filteredList = List<AppointmentDetailsModel>.of(_appointmentList);
    }
    isLoading = false;
    notifyListeners();
  }
}
