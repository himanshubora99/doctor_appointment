library view_appointments;

import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:appointment_booking/src/helper/utils.dart';
import 'package:appointment_booking/src/models/appointment_details_model.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctors_dashboard_screen.dart';
import 'package:appointment_booking/src/screens/my_bookings/my_appointment_provider.dart';
import 'package:appointment_booking/src/widgets/custom_button.dart';
import 'package:appointment_booking/src/widgets/custom_divider.dart';
import 'package:appointment_booking/src/widgets/custom_text.dart';
import 'package:appointment_booking/src/widgets/shimmer_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/custom_shimmer.dart';

class ViewMyAppointmentsScreen extends StatelessWidget {
  const ViewMyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAppointmentProvider>(
      create: (_) => MyAppointmentProvider(),
      builder: (BuildContext context, _) {
        context
            .read<MyAppointmentProvider>()
            .fetchAppointmentList(isBuildMethodAlreadyCalled: false);
        return _buildPage(context);
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MyAppointmentProvider>().fetchAppointmentList();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _appBar(context),
                20.ph,
                const CustomDivider(),
                _appointmentListWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Consumer<MyAppointmentProvider>(
        builder: (BuildContext context, MyAppointmentProvider provider, _) {
      if (provider.isSearching) {
        return _searchField(provider);
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
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
              text: 'My Bookings',
              size: 22,
              weight: FontWeight.w600,
            ),
            GestureDetector(
              onTap: () => provider.onSearchIconClickEvent(),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.customGrey)),
                  child: const Icon(Icons.search)),
            ),
          ],
        );
      }
    });
  }

  Widget _searchField(MyAppointmentProvider provider) {
    return TextField(
      onChanged: (String? val) => provider.onSearchDoctor(val ?? ''),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
        suffixIcon: InkWell(
            onTap: () => provider.onSearchCloseEvent(),
            child: const Icon(Icons.close, color: AppColors.textGrey)),
        counterText: '',
        hintText: 'Search Doctor',
        contentPadding: const EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.textGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.textGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.textGrey),
        ),
      ),
    );
  }

  Widget _appointmentListWidget() {
    return Consumer<MyAppointmentProvider>(
        builder: (BuildContext context, MyAppointmentProvider provider, _) {
      if (provider.isLoading) {
        return const _customShimmer();
      }
      if (provider.filteredList.isEmpty) {
        return const Expanded(
          child: Center(
            child: CustomText(text: 'No Appointments available'),
          ),
        );
      }
      return Expanded(
          child: ListView.builder(
              itemCount: provider.filteredList.length,
              itemBuilder: (BuildContext context, int index) {
                final AppointmentDetailsModel appointmentDetails =
                    provider.filteredList[index];
                return _doctorCard(
                  appointmentDetails: appointmentDetails,
                );
              }));
    });
  }

  Widget _doctorCard({
    required AppointmentDetailsModel appointmentDetails,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.customGrey, width: 1.5)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
              text:
                  '${Utils.getStringDateFormatDMonthNameY(dT: appointmentDetails.appointmentDate)} - ${appointmentDetails.appointmentTime.split(" - ")[0]}',
              weight: FontWeight.w600),
          const Divider(),
          10.ph,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              10.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                      text: appointmentDetails.doctorName,
                      weight: FontWeight.w600,
                      size: 18),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: AppColors.customBlue),
                      CustomText(text: appointmentDetails.location),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const CustomText(text: 'Booking ID : '),
                      CustomText(text: appointmentDetails.bookingId),
                    ],
                  ),
                ],
              )
            ],
          ),
          10.ph,
          const CustomDivider(),
          10.ph,
          Row(
            children: <Widget>[
              Flexible(
                child: CustomButton(
                  text: 'Cancel',
                  textColor: AppColors.customBlue,
                  onPressed: () {},
                  buttonColor: AppColors.lightBlue,
                  borderColor: AppColors.lightBlue,
                ),
              ),
              10.pw,
              Flexible(
                child: CustomButton(
                  text: 'Reschedule',
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
