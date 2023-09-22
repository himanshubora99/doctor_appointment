library select_package;

import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctor_dashboard_provider.dart';
import 'package:appointment_booking/src/screens/packages/package_provider.dart';
import 'package:appointment_booking/src/widgets/custom_button.dart';
import 'package:appointment_booking/src/widgets/custom_divider.dart';
import 'package:appointment_booking/src/widgets/custom_text.dart';
import 'package:appointment_booking/src/widgets/shimmer_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/custom_shimmer.dart';

late DoctorDashBoardProvider _doctorDashBoardPro;
late PackageProvider _packagePro;

class SelectPackageScreen extends StatelessWidget {
  const SelectPackageScreen({super.key});

  static Future<void> openScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<PackageProvider>(
                  create: (_) => PackageProvider(),
                  child: const SelectPackageScreen(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    _packagePro = Provider.of(context, listen: false);
    _doctorDashBoardPro = Provider.of(context, listen: false);
    _packagePro.fetchPackages(isBuildMethodAlreadyCalled: false);
    return WillPopScope(
      onWillPop: () async {
        _packagePro.onGoingBackEvent(
          context,
        );
        return Future<bool>.value(true);
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _packagePro.fetchPackages();
        },
        child: Scaffold(
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
                      onTap: () => _packagePro.onGoingBackEvent(context),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.customGrey)),
                          child: const Icon(Icons.arrow_back_outlined)),
                    ),
                    const CustomText(
                      text: 'Select Package',
                      size: 22,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(),
                  ],
                ),
                20.ph,
                _buildBody(context),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<PackageProvider>(
        builder: (BuildContext context, PackageProvider provider, _) {
      if (provider.isLoading) {
        return const _customShimmer();
      }
      if (provider.packageDetails == null) {
        return const Expanded(
          child: Center(
            child: CustomText(text: 'No Packages Available'),
          ),
        );
      }
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CustomText(
              text: 'Select Duration',
              size: 22,
              weight: FontWeight.w600,
            ),
            20.ph,
            _durationDropDown(context, provider),
            20.ph,
            const CustomText(
              text: 'Select Package',
              size: 22,
              weight: FontWeight.w600,
            ),
            20.ph,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List<Widget>.generate(
                      provider.packageDetails!.package.length, (int index) {
                    final String packageDetail =
                        provider.packageDetails!.package[index];
                    return _customRadioContainer(
                        heading: packageDetail,
                        groupValue: _doctorDashBoardPro
                            .createAppointmentModel.bookedPackage,
                        onChanged: (String? val) => provider
                            .onPackageSelectEvent(context, packageDetail));
                  }),
                ),
              ),
            ),
            const CustomDivider(),
            20.ph,
            CustomButton(
                text: 'Next',
                buttonColor: provider.isEnableButton(context)
                    ? null
                    : AppColors.customGrey,
                borderColor: provider.isEnableButton(context)
                    ? null
                    : AppColors.customGrey,
                textColor:
                    provider.isEnableButton(context) ? null : AppColors.white,
                onPressed: () => provider.onMakeApptClickEvent(context)),
          ],
        ),
      );
    });
  }

  String _getSubHeading(String heading) {
    if (heading == 'Messaging') {
      return 'Chat with Doctor';
    }
    if (heading == 'Voice Call') {
      return 'Voice call with doctor';
    }
    if (heading == 'Video Call') {
      return 'Video call with doctor';
    }
    if (heading == 'In Person') {
      return 'In Person visit with doctor';
    }
    return '';
  }

  IconData _getIcon(String heading) {
    if (heading == 'Messaging') {
      return Icons.message;
    }
    if (heading == 'Voice Call') {
      return Icons.phone;
    }
    if (heading == 'Video Call') {
      return Icons.video_camera_back;
    }
    if (heading == 'In Person') {
      return Icons.person;
    }
    return Icons.person;
  }

  Widget _durationDropDown(BuildContext context, PackageProvider provider) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      elevation: 10,
      hint: const Text('Select Duration'),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.customBlue),
      value: _doctorDashBoardPro.createAppointmentModel.bookedDuration,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.access_time_filled, color: AppColors.customBlue),
        counterText: '',
        contentPadding: const EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.customGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.customGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.customGrey),
        ),
      ),
      focusColor: AppColors.white,
      onChanged: (_) {},
      items: provider.packageDetails!.duration.map(
        (String duration) {
          return DropdownMenuItem<String>(
            value: duration,
            onTap: () => provider.onDurationSelectEvent(context, duration),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(duration),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _customRadioContainer(
      {required String heading,
      required String? groupValue,
      required void Function(String?)? onChanged}) {
    return GestureDetector(
      onTap: () => onChanged!(heading),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.customGrey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightBlue,
                    ),
                    child: Icon(
                      _getIcon(heading),
                      color: AppColors.customBlue,
                      size: 30,
                    )),
                10.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(text: heading, weight: FontWeight.w600),
                    CustomText(
                      text: _getSubHeading(heading),
                      color: AppColors.textGrey,
                    )
                  ],
                ),
              ],
            ),
            Radio<String>(
              value: heading,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColors.customBlue,
            )
          ],
        ),
      ),
    );
  }
}
