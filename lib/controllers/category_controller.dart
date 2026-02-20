import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryController extends GetxController {

  var isLoading = true.obs;
  var categories = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((snapshot) {
      categories.value = snapshot.docs;
      isLoading.value = false;
    });
  }
}
