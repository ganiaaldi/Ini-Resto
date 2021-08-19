class CustomerReview {
  CustomerReview({
    required this.id,
    required this.name,
    required this.review,
    required this.date,
  });

  String? id;
  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    id: json["id"],
    name: json["name"],
    review: json["review"],
    date: json["date"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "review": review,
    "date": date,
  };
}

class ResponseReview {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  ResponseReview(
      {required this.error, required this.message, required this.customerReviews});

  factory ResponseReview.fromJson(Map<String, dynamic> json) =>
      ResponseReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}