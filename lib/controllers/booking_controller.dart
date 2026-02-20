import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingController extends GetxController {

  var isLoading = false.obs;

  Future<void> bookAppointment(
      String professionalId,
      String professionalName,
      String category,
      DateTime date,
      TimeOfDay time,
      ) async {
    try {
      isLoading.value = true;

      await FirebaseFirestore.instance
          .collection('appointments')
          .add({
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "professionalId": professionalId,
        "professionalName": professionalName,
        "category": category,
        "date": date.toString(),
        "time": "${time.hour}:${time.minute}",
        "status": "confirmed",
        "createdAt": Timestamp.now(),
      });

      Get.snackbar("Success", "Appointment booked successfully");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}