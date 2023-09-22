import 'dart:convert';

import 'package:appointment_booking/src/apis/urls.dart';
import 'package:appointment_booking/src/models/appointment_details_model.dart';
import 'package:appointment_booking/src/models/booking_confirmation_model.dart';
import 'package:appointment_booking/src/models/doctor_list_model.dart';
import 'package:appointment_booking/src/models/package_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _singleton = ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal();

  Future<List<DoctorDetailsModel>?> fetchDoctorsApi() async {
    try {
      final Uri url = Uri.parse(ApiUrl.getDoctorListUrl);
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<DoctorDetailsModel> docList = <DoctorDetailsModel>[];
        final List<dynamic> jsonResponse = json.decode(response.body);
        for (final Map<String, dynamic> item in jsonResponse) {
          DoctorDetailsModel doctor = DoctorDetailsModel.fromMap(item);
          docList.add(doctor);
        }
        return docList;
      } else {
        throw Exception('Failed to load fetchDoctorList');
      }
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print('fetchDoctorList Error:${e.toString()}||$c');
      }
    }
    return null;
  }

  Future<BookingConfirmationModel?> fetchBookingConfirmationDetailsApi() async {
    try {
      final Uri url = Uri.parse(ApiUrl.getConfirmationUrl);
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return BookingConfirmationModel.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load fetchBookingConfirmationDetails');
      }
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print('fetchBookingConfirmationDetails Error:${e.toString()}||$c');
      }
    }
    return null;
  }

  Future<PackageDetailModel?> fetchPackageDetailsApi() async {
    try {
      final Uri url = Uri.parse(ApiUrl.getPackageDetailUrl);
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return PackageDetailModel.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load fetchPackageDetails');
      }
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print('fetchPackageDetails Error:${e.toString()}||$c');
      }
    }
    return null;
  }

  Future<List<AppointmentDetailsModel>?> fetchAppointmentList() async {
    try {
      final Uri url = Uri.parse(ApiUrl.getAppointmentListUrl);
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<AppointmentDetailsModel> appointmentList =
            <AppointmentDetailsModel>[];
        final List<dynamic> jsonResponse = json.decode(response.body);
        for (final Map<String, dynamic> item in jsonResponse) {
          AppointmentDetailsModel doctor =
              AppointmentDetailsModel.fromMap(item);
          appointmentList.add(doctor);
        }
        return appointmentList;
      } else {
        throw Exception('Failed to load fetchAppointmentList');
      }
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print('fetchAppointmentList Error:${e.toString()}||$c');
      }
    }
    return null;
  }
}
