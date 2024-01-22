part of '../add_employee_page.dart';

class DatePickerDialog extends StatelessWidget {
  const DatePickerDialog({
    required this.cubit,
    required this.options,
    super.key,
  });
  final AddEmployeeCubit cubit;
  final List<(DateOption, String)> options;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.03738317757,
      ),
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is DateSelected) {
            context.pop;
          }
        },
        builder: (innerContext, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(context.screenHeight * 0.02591792656),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.03738317757,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: context.screenWidth * 0.03738317757,
                    children: List.generate(
                      options.length,
                      (index) => DateChoice(
                        label: options[index].$2,
                        isSelected: cubit.value == options[index].$1,
                        onSelected: (val) =>
                            cubit.onChoiceChipTapped(val, options[index].$1),
                      ),
                    ),
                  ),
                ),
                TableCalendar<dynamic>(
                  calendarFormat: cubit.calendarFormat,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon:
                        SvgPicture.asset(AppAssets.calendarArrowLeft),
                    rightChevronIcon:
                        SvgPicture.asset(AppAssets.calendarArrowRight),
                  ),
                  firstDay: now,
                  lastDay: DateTime(2099),
                  currentDay: now,
                  focusedDay: cubit.focusedDay,
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    outsideDaysVisible: false,
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.mainColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.mainColor),
                      color: Colors.transparent,
                    ),
                    todayTextStyle: const TextStyle(color: AppColors.mainColor),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(cubit.selectedDay, day);
                  },
                  onDaySelected: cubit.onDaySelected,
                  onPageChanged: (focusedDay) {
                    focusedDay = focusedDay;
                  },
                ),
                Gap(context.screenHeight * 0.01727861771),
                const Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: SvgPicture.asset(AppAssets.calendarIcon),
                    ),
                    Text(cubit.formattedDate),
                    const Spacer(),
                    CancelButton(
                      onPressed: () => innerContext.pop,
                    ),
                    SizedBox(
                      width: context.screenWidth * 0.03738317757,
                    ),
                    SaveButton(
                      onPressed: () {
                        cubit.saveDate(
                          cubit.startDateController,
                        );
                      },
                    ),
                    SizedBox(
                      width: context.screenWidth * 0.03738317757,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
