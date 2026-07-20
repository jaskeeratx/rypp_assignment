/// Rating information as returned by the API.
class RatingModel {
  const RatingModel({required this.rate, required this.count});

  final double rate;
  final int count;

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Domain model representing a rentable bike/scooter.
///
/// The raw fakestoreapi.com product payload is remapped into
/// rental-marketplace terms:
///   title        -> bikeName
///   price        -> dailyRentalPrice
///   rating.rate  -> ratingValue
///   rating.count -> ratingCount
///
/// Availability does not come from the API - it is derived locally
/// from the item's index (even index = available, odd index = booked),
/// as specified by the assignment.
class ProductModel {
  const ProductModel({
    required this.id,
    required this.bikeName,
    required this.dailyRentalPrice,
    required this.image,
    required this.description,
    required this.ratingValue,
    required this.ratingCount,
    required this.isAvailable,
  });

  final int id;
  final String bikeName;
  final double dailyRentalPrice;
  final String image;
  final String description;
  final double ratingValue;
  final int ratingCount;
  final bool isAvailable;

  factory ProductModel.fromJson(Map<String, dynamic> json, int index) {
    final rating = json['rating'] is Map<String, dynamic>
        ? RatingModel.fromJson(json['rating'] as Map<String, dynamic>)
        : const RatingModel(rate: 0, count: 0);

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? index,
      bikeName: (json['title'] as String?) ?? 'Unknown Bike',
      dailyRentalPrice: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: (json['image'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      ratingValue: rating.rate,
      ratingCount: rating.count,
      // Even index = Available, Odd index = Booked.
      isAvailable: index % 2 == 0,
    );
  }
}
