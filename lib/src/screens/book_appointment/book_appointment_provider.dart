import 'package:appointment_booking/src/helper/toast_helper.dart';
import 'package:appointment_booking/src/helper/utils.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctor_dashboard_provider.dart';
import 'package:appointment_booking/src/screens/packages/select_package_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BookAppointmentProvider extends ChangeNotifier {
  List<DateTime> slotDateList = <DateTime>[];
  List<String> slotTimeList = <String>[];

  void addSlotDates(BuildContext context, DoctorDashBoardProvider provider) {
    List<String> list = <String>[];
    list = provider.createAppointmentModel.selectedDoctor!.availability!.keys
        .map((String e) => e)
        .toList();
    list.removeWhere((String element) => element.isEmpty);
    slotDateList = list.map((String e) => Utils.getFormattedDate(e)).toList();
    if (slotDateList.isNotEmpty) {
      onDateClickEvent(slotDateList[0], provider, isNotifying: false);
    }
  }

  void onDateClickEvent(DateTime date, DoctorDashBoardProvider provider,
      {bool isNotifying = true}) {
    provider.createAppointmentModel.bookedDate = date;
    provider.createAppointmentModel.bookedTime = null;
    slotTimeList = <String>[];

    if ((provider.createAppointmentModel.selectedDoctor!.availability
                ?.isNotEmpty ??
            false) &&
        provider.createAppointmentModel.selectedDoctor!.availability!
            .containsKey(Utils.getStringDateFormatYMD(
                dT: provider.createAppointmentModel.bookedDate))) {
      slotTimeList.addAll(
          provider.createAppointmentModel.selectedDoctor!.availability![
              Utils.getStringDateFormatYMD(
                  dT: provider.createAppointmentModel.bookedDate)]!);
      slotTimeList.removeWhere((String element) => element.isEmpty);
      slotTimeList = slotTimeList.map((String e) => e.split(" - ")[0]).toList();
    }

    if (isNotifying) {
      notifyListeners();
    }
  }

  void onTimeClickEvent(String value, DoctorDashBoardProvider provider) {
    provider.createAppointmentModel.bookedTime = value.split(" - ")[0];
    notifyListeners();
  }

  void onGoingBackEvent(BuildContext context) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    provider.createAppointmentModel.bookedDate = null;
    provider.createAppointmentModel.bookedTime = null;
    Navigator.pop(context);
  }

  void onMakeApptClickEvent(BuildContext context) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    if (provider.createAppointmentModel.bookedDate == null) {
      ToastHelper.showToast('Please select a date');
      return;
    }
    if (provider.createAppointmentModel.bookedTime?.isEmpty ?? true) {
      ToastHelper.showToast('Please select time');
      return;
    }
    SelectPackageScreen.openScreen(context);
  }

  bool isEnableButton(BuildContext context) {
    DoctorDashBoardProvider provider = Provider.of(context, listen: false);
    if (provider.createAppointmentModel.bookedDate == null) {
      return false;
    }
    if (provider.createAppointmentModel.bookedTime?.isEmpty ?? true) {
      return false;
    }
    return true;
  }
}
