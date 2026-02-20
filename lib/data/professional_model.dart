class ProfessionalModel {
  final String id;
  final String name;
  final String category;
  final int experience;
  final double rating;
  final int price;

  ProfessionalModel({
    required this.id,
    required this.name,
    required this.category,
    required this.experience,
    required this.rating,
    required this.price,
  });

  factory ProfessionalModel.fromMap(
      String id, Map<String, dynamic> data) {
    return ProfessionalModel(
      id: id,
      name: data['name'],
      category: data['category'],
      experience: data['experience'],
      rating: (data['rating'] as num).toDouble(),
      price: data['price'],
    );
  }
}