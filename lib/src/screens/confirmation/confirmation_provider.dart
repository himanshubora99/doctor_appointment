import 'package:appointment_booking/src/models/booking_confirmation_model.dart';
import 'package:appointment_booking/src/providers/api_provider.dart';
import 'package:flutter/cupertino.dart';

class ConfirmationProvider extends ChangeNotifier {
  bool isLoading = true;
  BookingConfirmationModel? confirmationDetails;

  Future<void> fetchBookingConfirmationDetailsApi(
      {bool isBuildMethodAlreadyCalled = true}) async {
    isLoading = true;
    if (isBuildMethodAlreadyCalled) {
      notifyListeners();
    }
    final BookingConfirmationModel? responseData =
        await ApiProvider().fetchBookingConfirmationDetailsApi();
    if (responseData != null) {
      confirmationDetails = responseData;
    }
    isLoading = false;
    notifyListeners();
  }
}
