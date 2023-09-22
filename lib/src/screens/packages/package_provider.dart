import 'package:appointment_booking/src/helper/toast_helper.dart';
import 'package:appointment_booking/src/models/package_details_model.dart';
import 'package:appointment_booking/src/providers/api_provider.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctor_dashboard_provider.dart';
import 'package:appointment_booking/src/screens/review_summary/review_booking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PackageProvider extends ChangeNotifier {
  bool isLoading = true;
  PackageDetailModel? packageDetails;

  void onGoingBackEvent(BuildContext context) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    provider.createAppointmentModel.bookedDuration = null;
    provider.createAppointmentModel.bookedPackage = null;
    Navigator.pop(context);
  }

  void onDurationSelectEvent(BuildContext context, String bookedDuration) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    provider.createAppointmentModel.bookedDuration = bookedDuration;
    notifyListeners();
  }

  void onPackageSelectEvent(BuildContext context, String bookedPackage) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    provider.createAppointmentModel.bookedPackage = bookedPackage;
    notifyListeners();
  }

  Future<void> fetchPackages({bool isBuildMethodAlreadyCalled = true}) async {
    isLoading = true;
    if (isBuildMethodAlreadyCalled) {
      notifyListeners();
    }
    final PackageDetailModel? responseData =
        await ApiProvider().fetchPackageDetailsApi();
    if (responseData != null) {
      packageDetails = responseData;
    }
    isLoading = false;
    notifyListeners();
  }

  void onMakeApptClickEvent(BuildContext context) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    if (provider.createAppointmentModel.bookedDuration == null) {
      ToastHelper.showToast('Please select a duration');
      return;
    }
    if (provider.createAppointmentModel.bookedPackage == null) {
      ToastHelper.showToast('Please select package');
      return;
    }
    ReviewBookingScreen.openScreen(context);
  }

  bool isEnableButton(BuildContext context) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    if (provider.createAppointmentModel.bookedDuration == null) {
      return false;
    }
    if (provider.createAppointmentModel.bookedPackage?.isEmpty ?? true) {
      return false;
    }
    return true;
  }
}
