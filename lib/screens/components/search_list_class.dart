// ignore_for_file: prefer_typing_uninitialized_variables

class Autogenerated {
  int? businessAccId;
  String? businessName;
  String? email;
  String? phone;
  String? businessDescripition;
  String? openingTime;
  String? closingTime;
  String? businessSubCategory;
  String? fullAddress;
  String? houseNo;
  String? postalCode;
  String? cityOrTown;
  String? countyLocality;
  String? countryNation;
  var latitude;
  var longtitude;
  double? rating;
  String? image;
  List? activeDays;
  String? createdAt;

  Autogenerated(
      {this.businessAccId,
      this.businessName,
      this.email,
      this.phone,
      this.businessDescripition,
      this.openingTime,
      this.closingTime,
      this.businessSubCategory,
      this.fullAddress,
      this.houseNo,
      this.postalCode,
      this.cityOrTown,
      this.countyLocality,
      this.countryNation,
      this.latitude,
      this.longtitude,
      this.rating,
      this.image,
      this.activeDays,
      this.createdAt});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    businessAccId = json["business_account_id"];
    businessName = json['business_name'];
    email = json['email'];
    phone = json['phone'];
    businessDescripition = json['business_descripition'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    businessSubCategory = json['business_sub_category'];
    fullAddress = json['full_address'];
    houseNo = json['house_no'];
    postalCode = json['postal_code'];
    cityOrTown = json['city_or_town'];
    countyLocality = json['county_locality'];
    countryNation = json['country_nation'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    rating = json['rating'];
    image = json["acc_main_image"];
    activeDays = json['active_days'].cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_name'] = businessName;
    data['email'] = email;
    data['phone'] = phone;
    data['business_descripition'] = businessDescripition;
    data['opening_time'] = openingTime;
    data['closing_time'] = closingTime;
    data['business_sub_category'] = businessSubCategory;
    data['full_address'] = fullAddress;
    data['house_no'] = houseNo;
    data['postal_code'] = postalCode;
    data['city_or_town'] = cityOrTown;
    data['county_locality'] = countyLocality;
    data['country_nation'] = countryNation;
    data['latitude'] = latitude;
    data['longtitude'] = longtitude;
    data['rating'] = rating;
    data['active_days'] = activeDays;
    data['created_at'] = createdAt;
    return data;
  }
}
