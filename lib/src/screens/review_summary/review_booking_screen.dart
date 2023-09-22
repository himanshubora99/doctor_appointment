import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:appointment_booking/src/helper/utils.dart';
import 'package:appointment_booking/src/models/create_appointment_model.dart';
import 'package:appointment_booking/src/screens/confirmation/confirmation_screen.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctor_dashboard_provider.dart';
import 'package:appointment_booking/src/widgets/custom_button.dart';
import 'package:appointment_booking/src/widgets/custom_divider.dart';
import 'package:appointment_booking/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late DoctorDashBoardProvider _doctorDashBoardPro;

class ReviewBookingScreen extends StatelessWidget {
  const ReviewBookingScreen({super.key});

  static Future<void> openScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const ReviewBookingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    _doctorDashBoardPro = Provider.of(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.customGrey)),
                        child: const Icon(Icons.arrow_back_outlined)),
                  ),
                  const CustomText(
                    text: 'Review Summary',
                    size: 22,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(),
                ],
              ),
              20.ph,
              _doctorPersonalDetails(),
              10.ph,
              const CustomDivider(),
              10.ph,
              _customBookingDetailRow(
                  key: 'Date & Hour',
                  value:
                      '${Utils.getStringDateFormatDMonthNameY(dT: _doctorDashBoardPro.createAppointmentModel.bookedDate)} | ${_doctorDashBoardPro.createAppointmentModel.bookedTime}'),
              _customBookingDetailRow(
                  key: 'Package',
                  value: _doctorDashBoardPro
                      .createAppointmentModel.bookedPackage!),
              _customBookingDetailRow(
                  key: 'Duration',
                  value: _doctorDashBoardPro
                      .createAppointmentModel.bookedDuration!),
              _customBookingDetailRow(key: 'Booking For', value: 'Self'),
              const Spacer(),
              const CustomDivider(),
              10.ph,
              CustomButton(
                  text: 'Make Appointment',
                  onPressed: () {
                    _doctorDashBoardPro.createAppointmentModel =
                        CreateAppointmentModel();
                    ConfirmationScreen.openScreen(context);
                  }),
            ]),
      )),
    );
  }

  Widget _doctorPersonalDetails() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: _doctorDashBoardPro
                    .createAppointmentModel.selectedDoctor!.image.isEmpty
                ? null
                : DecorationImage(
                    image: NetworkImage(_doctorDashBoardPro
                        .createAppointmentModel.selectedDoctor!.image),
                    onError: (Object obj, StackTrace? st) {}),
            shape: BoxShape.circle,
            color: AppColors.lightGrey,
          ),
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
                text: _doctorDashBoardPro
                    .createAppointmentModel.selectedDoctor!.doctorName,
                weight: FontWeight.w600,
                size: 22),
            CustomText(
                text: _doctorDashBoardPro
                    .createAppointmentModel.selectedDoctor!.speciality,
                color: AppColors.textGrey),
            Row(
              children: <Widget>[
                const Icon(Icons.location_on_outlined,
                    size: 18, color: AppColors.customBlue),
                CustomText(
                    text: _doctorDashBoardPro
                        .createAppointmentModel.selectedDoctor!.location,
                    color: AppColors.textGrey),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _customBookingDetailRow({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[CustomText(text: key), CustomText(text: value)],
    );
  }
}
