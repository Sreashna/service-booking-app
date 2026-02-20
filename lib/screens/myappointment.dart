import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_color.dart';

class MyAppointmentsScreen extends StatelessWidget {
  MyAppointmentsScreen({super.key});

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "My Appointments",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _emptyState(context);
          }

          final appointments = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appointments.length,
            itemBuilder: (context, index) {

              final data =
              appointments[index].data() as Map<String, dynamic>;

              final status =
                  data['status']?.toString() ?? "Pending";

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor,
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: Text(
                            data['professionalName']
                                ?.toString() ??
                                "Not Available",
                            style: theme.textTheme.titleMedium
                                ?.copyWith(
                                fontWeight:
                                FontWeight.w600),
                          ),
                        ),

                        _statusBadge(status),
                      ],
                    ),

                    const SizedBox(height: 12),

                    _infoRow(
                        context,
                        Icons.category,
                        data['category']
                            ?.toString() ??
                            "N/A"),

                    const SizedBox(height: 8),

                    _infoRow(
                        context,
                        Icons.calendar_today,
                        data['date']
                            ?.toString() ??
                            "N/A"),

                    const SizedBox(height: 8),

                    _infoRow(
                        context,
                        Icons.access_time,
                        data['time']
                            ?.toString() ??
                            "N/A"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
  Widget _statusBadge(String status) {
    Color bgColor;

    if (status.toLowerCase() == "confirmed") {
      bgColor = Colors.green;
    } else if (status.toLowerCase() == "cancelled") {
      bgColor = Colors.red;
    } else {
      bgColor = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  Widget _infoRow(
      BuildContext context, IconData icon, String value) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
  Widget _emptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy,
              size: 60,
              color: theme.hintColor),
          const SizedBox(height: 15),
          Text(
            "No Appointments Yet",
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}