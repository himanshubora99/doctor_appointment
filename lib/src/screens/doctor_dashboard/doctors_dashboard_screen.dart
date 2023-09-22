library doctor_dashboard;

import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:appointment_booking/src/models/doctor_list_model.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctor_dashboard_provider.dart';
import 'package:appointment_booking/src/widgets/custom_button.dart';
import 'package:appointment_booking/src/widgets/custom_divider.dart';
import 'package:appointment_booking/src/widgets/custom_text.dart';
import 'package:appointment_booking/src/widgets/shimmer_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/custom_shimmer.dart';

class DoctorsDashBoard extends StatelessWidget {
  const DoctorsDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<DoctorDashBoardProvider>()
        .fetchDoctorList(isBuildMethodAlreadyCalled: false);
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DoctorDashBoardProvider>().fetchDoctorList();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: <Widget>[
                10.ph,
                const Center(
                    child: CustomText(
                  text: 'Doctors',
                  size: 22,
                  weight: FontWeight.w600,
                )),
                const CustomDivider(),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<DoctorDashBoardProvider>(
        builder: (BuildContext context, DoctorDashBoardProvider provider, _) {
      if (provider.isLoading) {
        return const _customShimmer();
      }
      if (provider.doctorList.isEmpty) {
        return const Expanded(
          child: Center(
            child: CustomText(text: 'No Doctors Available'),
          ),
        );
      }
      return Expanded(
        child: ListView.builder(
            itemCount: provider.doctorList.length,
            itemBuilder: (BuildContext context, int index) {
              final DoctorDetailsModel doctorDetails =
                  provider.doctorList[index];
              return _doctorCard(
                  onPressed: () =>
                      provider.onBookClickEvent(context, doctorDetails),
                  doctorDetails: doctorDetails);
            }),
      );
    });
  }

  Widget _doctorCard({
    required void Function() onPressed,
    required DoctorDetailsModel doctorDetails,
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(15),
                    image: doctorDetails.image.isEmpty
                        ? null
                        : DecorationImage(
                            image: NetworkImage(doctorDetails.image),
                            onError: (Object obj, StackTrace? st) {})),
              ),
              10.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                      text: doctorDetails.doctorName,
                      weight: FontWeight.w600,
                      size: 18),
                  5.ph,
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: AppColors.customBlue),
                      CustomText(
                          text: doctorDetails.location,
                          color: AppColors.textGrey),
                    ],
                  ),
                  5.ph,
                  CustomText(
                      text: doctorDetails.speciality,
                      color: AppColors.textGrey),
                ],
              )
            ],
          ),
          10.ph,
          const CustomDivider(),
          10.ph,
          CustomButton(
            text: 'Book',
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
