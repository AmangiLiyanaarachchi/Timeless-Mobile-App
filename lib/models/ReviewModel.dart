class ReviewModel {
  late String id;
  late String productId;
  late String review;
  late double rating;
  late String creatorId;
  DateTime? createdOn;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.review,
    required this.rating,
    required this.creatorId,
    this.createdOn,
  });

  ReviewModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    productId = map["productId"];
    review = map["review"];
    rating = map["rating"];
    creatorId = map["creatorId"];
    createdOn = map["createdOn"].toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productId": productId,
      "review": review,
      "createdOn": createdOn,
      "rating": rating,
      "creatorId": creatorId
    };
  }
}
