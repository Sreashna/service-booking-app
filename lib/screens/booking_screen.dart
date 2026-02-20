import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/professional_model.dart';
import '../controllers/booking_controller.dart';
import '../theme/app_color.dart';

class BookingScreen extends StatelessWidget {
  final ProfessionalModel professional;

  BookingScreen({super.key, required this.professional});

  final BookingController controller =
  Get.put(BookingController());

  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Book Appointment",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius:
                BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor,
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Row(
                children: [

                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          professional.name,
                          style: theme
                              .textTheme.titleMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          professional.category,
                          style: theme
                              .textTheme.bodySmall
                              ?.copyWith(
                            color:
                            theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _selectionCard(
              context: context,
              icon: Icons.calendar_today,
              title: "Select Date",
              onTap: () async {
                final date =
                await showDatePicker(
                  context: context,
                  firstDate:
                  DateTime.now(),
                  lastDate:
                  DateTime(2030),
                  initialDate:
                  DateTime.now(),
                );
                if (date != null) {
                  selectedDate.value =
                      date;
                }
              },
              valueWidget: Obx(() =>
              selectedDate.value ==
                  null
                  ? Text(
                "Choose date",
                style: theme
                    .textTheme
                    .bodySmall,
              )
                  : Text(
                "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}",
                style: theme
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              )),
            ),

            const SizedBox(height: 20),
            _selectionCard(
              context: context,
              icon: Icons.access_time,
              title: "Select Time",
              onTap: () async {
                final time =
                await showTimePicker(
                  context: context,
                  initialTime:
                  TimeOfDay.now(),
                );
                if (time != null) {
                  selectedTime.value =
                      time;
                }
              },
              valueWidget: Obx(() =>
              selectedTime.value ==
                  null
                  ? Text(
                "Choose time",
                style: theme
                    .textTheme
                    .bodySmall,
              )
                  : Text(
                selectedTime.value!
                    .format(context),
                style: theme
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              )),
            ),

            const Spacer(),
            Obx(() =>
            controller.isLoading.value
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  if (selectedDate.value ==
                      null ||
                      selectedTime.value ==
                          null) {
                    Get.snackbar(
                      "Error",
                      "Please select date & time",
                      backgroundColor:
                      Colors.red,
                      colorText:
                      Colors.white,
                    );
                    return;
                  }

                  controller
                      .bookAppointment(
                    professional.id,
                    professional.name,
                    professional.category,
                    selectedDate.value!,
                    selectedTime.value!,
                  );
                },
                style: ElevatedButton
                    .styleFrom(
                  backgroundColor:
                  AppColors.primary,
                  padding:
                  const EdgeInsets
                      .symmetric(
                      vertical:
                      16),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                        18),
                  ),
                ),
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
  Widget _selectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Widget valueWidget,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius:
          BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme
                    .textTheme.bodyMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ),
            valueWidget,
          ],
        ),
      ),
    );
  }
}