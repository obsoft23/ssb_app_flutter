class ReviewComment {
  int? id;
  String? review;
  double? rating;
  int? reviewerId;
  int? businessAccountId;
  String? createdAt;

  ReviewComment({
    this.id,
    this.review,
    this.rating,
    this.reviewerId,
    this.businessAccountId,
    this.createdAt,
  });

  ReviewComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rating = json['rating'];
    reviewerId = json['reviewer_id'];
    businessAccountId = json['business_account_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['review'] = review;
    data['rating'] = rating;
    data['reviewer_id'] = reviewerId;
    data['business_account_id'] = businessAccountId;
    data['created_at'] = createdAt;
    return data;
  }
}

class ReviewProfile {
  int? id;
  String? name;
  String? image;

  ReviewProfile({this.id, this.name, this.image});

  ReviewProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
