abstract class ApiUrl {
  static const String _baseUrl =
      'https://my-json-server.typicode.com/githubforekam/doctor-appointment';
  static const String getDoctorListUrl = '$_baseUrl/doctors';
  static const String getPackageDetailUrl = '$_baseUrl/appointment_options';
  static const String getConfirmationUrl = '$_baseUrl/booking_confirmation';
  static const String getAppointmentListUrl = '$_baseUrl/appointments';
}
