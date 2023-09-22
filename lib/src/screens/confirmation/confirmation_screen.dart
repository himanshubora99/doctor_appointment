library confirmation;

import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:appointment_booking/src/helper/utils.dart';
import 'package:appointment_booking/src/screens/confirmation/confirmation_provider.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctors_dashboard_screen.dart';
import 'package:appointment_booking/src/screens/my_bookings/view_appointments_screen.dart';
import 'package:appointment_booking/src/widgets/custom_button.dart';
import 'package:appointment_booking/src/widgets/custom_divider.dart';
import 'package:appointment_booking/src/widgets/custom_text.dart';
import 'package:appointment_booking/src/widgets/dotted_divider.dart';
import 'package:appointment_booking/src/widgets/shimmer_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/custom_shimmer.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  static Future<void> openScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<ConfirmationProvider>(
                  create: (_) => ConfirmationProvider(),
                  child: const ConfirmationScreen(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ConfirmationProvider>()
        .fetchBookingConfirmationDetailsApi(isBuildMethodAlreadyCalled: false);
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<ConfirmationProvider>()
            .fetchBookingConfirmationDetailsApi();
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) {
                        return const DoctorsDashBoard();
                      }), (Route<dynamic> route) => false);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.customGrey)),
                        child: const Icon(Icons.arrow_back_outlined)),
                  ),
                  const CustomText(
                    text: 'Confirmation',
                    size: 22,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(),
                ],
              ),
              20.ph,
              _buildBody(context)
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<ConfirmationProvider>(
        builder: (BuildContext context, ConfirmationProvider provider, _) {
      if (provider.isLoading) {
        return const _customShimmer();
      }
      if (provider.confirmationDetails == null) {
        return const Expanded(
          child: Center(
            child: CustomText(text: 'Confirmation Not Available'),
          ),
        );
      }
      return Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: context.mWidth / 3,
                  height: context.mHeight / 3,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.customBlue),
                  child:
                      const Icon(Icons.check, color: AppColors.white, size: 50),
                ),
                const CustomText(
                    text: 'Appointment confirmed!',
                    weight: FontWeight.w600,
                    size: 22),
                10.ph,
                const CustomText(
                    text: 'You have successfully booked an appointment with',
                    color: AppColors.textGrey),
                5.ph,
                CustomText(
                    text: provider.confirmationDetails!.doctorName,
                    weight: FontWeight.w600),
              ],
            ),
          ),
          20.ph,
          const DottedDivider(
            gapWidth: 8,
          ),
          20.ph,
          Row(children: <Widget>[
            const Icon(
              Icons.person,
              color: AppColors.customBlue,
            ),
            10.pw,
            const CustomText(text: 'Esther Howard')
          ]),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.calendar_month,
                    color: AppColors.customBlue,
                  ),
                  10.pw,
                  CustomText(
                      text:
                          provider.confirmationDetails!.appointmentDate == null
                              ? 'N/A'
                              : Utils.getStringDateFormatDMonthNameY(
                                  dT: provider
                                      .confirmationDetails!.appointmentDate))
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.timer,
                    color: AppColors.customBlue,
                  ),
                  10.pw,
                  CustomText(
                      text: provider.confirmationDetails!.appointmentTime)
                ],
              ),
              const SizedBox()
            ],
          ),
          const Spacer(),
          const CustomDivider(),
          10.ph,
          CustomButton(
              text: 'View Appointments',
              onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const ViewMyAppointmentsScreen();
                }), (Route<dynamic> route) => false);
              }),
          20.ph,
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const DoctorsDashBoard();
                }), (Route<dynamic> route) => false);
              },
              child: const CustomText(
                text: 'Book Another',
                size: 16,
                weight: FontWeight.w600,
                color: AppColors.customBlue,
              ),
            ),
          ),
          20.ph,
        ],
      ));
    });
  }
}
