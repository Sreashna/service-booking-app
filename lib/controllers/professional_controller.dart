import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/professional_model.dart';

class ProfessionalController extends GetxController {

  var professionals = <ProfessionalModel>[].obs;

  var isLoading = true.obs;
  var isLoadingMore = false.obs;

  var selectedSort = "price_low".obs;
  var selectedCategory = "".obs;

  DocumentSnapshot? lastDocument;
  final int limit = 5;

  Future<void> fetchProfessionals(String category) async {

    selectedCategory.value = category;
    isLoading.value = true;

    final query = await FirebaseFirestore.instance
        .collection('professionals')
        .where('category', isEqualTo: category)
        .limit(limit)
        .get();

    professionals.value = query.docs
        .map((doc) => ProfessionalModel.fromMap(
      doc.id,
      doc.data(),
    ))
        .toList();

    if (query.docs.isNotEmpty) {
      lastDocument = query.docs.last;
    }

    applySorting(selectedSort.value);

    isLoading.value = false;
  }
  Future<void> loadMore() async {

    if (lastDocument == null) return;

    isLoadingMore.value = true;

    final query = await FirebaseFirestore.instance
        .collection('professionals')
        .where('category',
        isEqualTo: selectedCategory.value)
        .startAfterDocument(lastDocument!)
        .limit(limit)
        .get();

    final newItems = query.docs
        .map((doc) => ProfessionalModel.fromMap(
      doc.id,
      doc.data(),
    ))
        .toList();

    professionals.addAll(newItems);

    if (query.docs.isNotEmpty) {
      lastDocument = query.docs.last;
    }

    applySorting(selectedSort.value);

    isLoadingMore.value = false;
  }

  void applySorting(String sortType) {

    selectedSort.value = sortType;

    if (sortType == "price_low") {
      professionals.sort((a, b) =>
          a.price.compareTo(b.price));
    }
    else if (sortType == "price_high") {
      professionals.sort((a, b) =>
          b.price.compareTo(a.price));
    }
    else if (sortType == "rating_high") {
      professionals.sort((a, b) =>
          b.rating.compareTo(a.rating));
    }
  }
}