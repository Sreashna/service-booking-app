import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app1/screens/professional_detail_screen.dart';
import '../controllers/professional_controller.dart';
import '../theme/app_color.dart';

class ProfessionalListScreen extends StatefulWidget {
  final String category;

  const ProfessionalListScreen({super.key, required this.category});

  @override
  State<ProfessionalListScreen> createState() =>
      _ProfessionalListScreenState();
}

class _ProfessionalListScreenState
    extends State<ProfessionalListScreen> {

  final ProfessionalController controller =
  Get.put(ProfessionalController());

  final ScrollController scrollController =
  ScrollController();

  @override
  void initState() {
    super.initState();

    controller.fetchProfessionals(widget.category);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary,
                ),
              ),
              child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedSort.value,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.sort,
                    color: AppColors.primary,
                  ),
                  style: theme.textTheme.bodyMedium,
                  items: const [
                    DropdownMenuItem(
                        value: "price_low",
                        child: Text("Price: Low to High")),
                    DropdownMenuItem(
                        value: "price_high",
                        child: Text("Price: High to Low")),
                    DropdownMenuItem(
                        value: "rating_high",
                        child: Text("Rating: High to Low")),
                  ],
                  onChanged: (value) {
                    controller.applySorting(value!);
                  },
                ),
              )),
            ),
          ),
          Expanded(
            child: Obx(() {

              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator());
              }

              if (controller.professionals.isEmpty) {
                return Center(
                  child: Text(
                    "No professionals found",
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }

              return ListView.builder(
                controller: scrollController,
                padding:
                const EdgeInsets.symmetric(horizontal: 16),
                itemCount:
                controller.professionals.length + 1,
                itemBuilder: (context, index) {

                  if (index <
                      controller.professionals.length) {

                    final pro =
                    controller.professionals[index];

                    return Container(
                      margin:
                      const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius:
                        BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor,
                            blurRadius: 15,
                            offset:
                            const Offset(0, 8),
                          )
                        ],
                      ),
                      child: InkWell(
                        borderRadius:
                        BorderRadius.circular(20),
                        onTap: () {
                          Get.to(() =>
                              ProfessionalDetailScreen(
                                professional: pro,
                              ));
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color:
                                  AppColors.white,
                                  size: 28,
                                ),
                              ),

                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [

                                    Text(
                                      pro.name,
                                      style: theme
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 6),

                                    Text(
                                      "${pro.experience} yrs experience",
                                      style: theme
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                        color: theme
                                            .hintColor,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 6),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors
                                              .amber,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                            width: 4),
                                        Text(
                                          pro.rating
                                              .toString(),
                                          style: theme
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                    horizontal:
                                    14,
                                    vertical:
                                    8),
                                decoration:
                                BoxDecoration(
                                  color: AppColors
                                      .primary,
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      25),
                                ),
                                child: Text(
                                  "₹${pro.price}",
                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.white,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Obx(() =>
                  controller.isLoadingMore.value
                      ? const Padding(
                    padding:
                    EdgeInsets.all(
                        15),
                    child: Center(
                        child:
                        CircularProgressIndicator()),
                  )
                      : const SizedBox());
                },
              );
            }),
          )
        ],
      ),
    );
  }
}