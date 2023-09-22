import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:appointment_booking/src/helper/extensions.dart';
import 'package:appointment_booking/src/helper/utils.dart';
import 'package:appointment_booking/src/screens/book_appointment/book_appointment_provider.dart';
import 'package:appointment_booking/src/screens/doctor_dashboard/doctor_dashboard_provider.dart';
import 'package:appointment_booking/src/widgets/custom_button.dart';
import 'package:appointment_booking/src/widgets/custom_divider.dart';
import 'package:appointment_booking/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late DoctorDashBoardProvider _doctorDashBoardPro;
late BookAppointmentProvider _bookAppointmentPro;

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  static Future<void> openScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<BookAppointmentProvider>(
                  create: (_) => BookAppointmentProvider(),
                  child: const BookAppointmentScreen(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    _doctorDashBoardPro = Provider.of(context, listen: false);
    _bookAppointmentPro = Provider.of(context, listen: false);
    _bookAppointmentPro.addSlotDates(context, _doctorDashBoardPro);
    return WillPopScope(
      onWillPop: () async {
        _bookAppointmentPro.onGoingBackEvent(context);
        return Future<bool>.value(true);
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
                    onTap: () => _bookAppointmentPro.onGoingBackEvent(context),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.customGrey)),
                        child: const Icon(Icons.arrow_back_outlined)),
                  ),
                  const CustomText(
                    text: 'Book Appointment',
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
              _buildPage(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<BookAppointmentProvider>(
        builder: (BuildContext context, BookAppointmentProvider provider, _) {
      return Expanded(
        child: Column(
          children: <Widget>[
            _professionalDetails(),
            20.ph,
            const CustomText(
              text: 'BOOK APPOINTMENT',
              color: AppColors.textGrey,
            ),
            20.ph,
            if (provider.slotDateList.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _slotDateListWidget(),
                  20.ph,
                  if (provider.slotTimeList.isNotEmpty)
                    _slotTimeListWidget(context)
                  else
                    const Center(
                      child: CustomText(
                          text: 'No Slots Time Available',
                          weight: FontWeight.w600),
                    ),
                ],
              )
            else
              const CustomText(
                  text: 'No Slots Date Available', weight: FontWeight.w600),
            const Spacer(),
            const CustomDivider(),
            10.ph,
            CustomButton(
                text: 'Make Appointment',
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

  Widget _professionalDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBlue,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.customBlue,
                  size: 30,
                )),
            10.ph,
            CustomText(
                text:
                    '${_doctorDashBoardPro.createAppointmentModel.selectedDoctor!.patientsServed}+'),
            const CustomText(text: 'Patients', color: AppColors.textGrey),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBlue,
                ),
                child: const Icon(
                  Icons.card_travel,
                  color: AppColors.customBlue,
                  size: 30,
                )),
            10.ph,
            CustomText(
                text:
                    '${_doctorDashBoardPro.createAppointmentModel.selectedDoctor!.yearsOfExperience}+'),
            const CustomText(text: 'Years Exp.', color: AppColors.textGrey),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBlue,
                ),
                child: const Icon(
                  Icons.star,
                  color: AppColors.customBlue,
                  size: 30,
                )),
            10.ph,
            CustomText(
                text:
                    '${_doctorDashBoardPro.createAppointmentModel.selectedDoctor!.rating}+'),
            const CustomText(text: 'Rating', color: AppColors.textGrey),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBlue,
                ),
                child: const Icon(
                  Icons.message,
                  color: AppColors.customBlue,
                  size: 30,
                )),
            10.ph,
            CustomText(
                text:
                    '${_doctorDashBoardPro.createAppointmentModel.selectedDoctor!.numberOfReviews}+'),
            const CustomText(text: 'Review', color: AppColors.textGrey),
          ],
        ),
      ],
    );
  }

  Widget _slotDateListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          text: 'Day',
          size: 18,
          weight: FontWeight.w600,
        ),
        10.ph,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List<Widget>.generate(
                _bookAppointmentPro.slotDateList.length, (int index) {
              final DateTime date = _bookAppointmentPro.slotDateList[index];
              bool isSelectedDate = Utils.getDateOnlyFormatYMD(
                      dT: _doctorDashBoardPro.createAppointmentModel.bookedDate)
                  .isAtSameMomentAs(Utils.getDateOnlyFormatYMD(dT: date));
              return GestureDetector(
                onTap: () => _bookAppointmentPro.onDateClickEvent(
                    date, _doctorDashBoardPro),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isSelectedDate ? AppColors.customBlue : null,
                    border: Border.all(
                        color: isSelectedDate
                            ? AppColors.customBlue
                            : AppColors.customGrey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: Utils.getDateOnlyFormatYMD(dT: date)
                                .isAtSameMomentAs(Utils.getDateOnlyFormatYMD(
                                    dT: DateTime.now()))
                            ? 'Today'
                            : Utils.getWeekDayInShort(dateTime: date),
                        color: isSelectedDate ? AppColors.white : null,
                      ),
                      CustomText(
                          text: Utils.getStringDateFormatDateMonth(dT: date)
                              .replaceAll('-', ' '),
                          weight: FontWeight.w600,
                          color: isSelectedDate ? AppColors.white : null),
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  Widget _slotTimeListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          text: 'Time',
          size: 18,
          weight: FontWeight.w600,
        ),
        10.ph,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List<Widget>.generate(
                _bookAppointmentPro.slotTimeList.length, (int index) {
              final String slotTiming = _bookAppointmentPro.slotTimeList[index];
              bool isSelectedSlotTiming =
                  _doctorDashBoardPro.createAppointmentModel.bookedTime ==
                      slotTiming;
              return GestureDetector(
                onTap: () => _bookAppointmentPro.onTimeClickEvent(
                    slotTiming, _doctorDashBoardPro),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isSelectedSlotTiming ? AppColors.customBlue : null,
                    border: Border.all(
                        color: isSelectedSlotTiming
                            ? AppColors.customBlue
                            : AppColors.customGrey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: CustomText(
                      text: slotTiming.split(" - ")[0],
                      weight: FontWeight.w600,
                      size: 16,
                      color: isSelectedSlotTiming ? AppColors.white : null,
                    ),
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
