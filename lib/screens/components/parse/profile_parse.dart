class Profile {
  final int? id;
  final String? name;
  final String? email;
  final String? fullname;
  final String? bio;
  final String? image;
  final String? phone;
  final String? token;
  final dynamic hasProfessionalAcc;
  Profile({
    this.id,
    this.name,
    this.email,
    this.fullname,
    this.bio,
    this.image,
    this.phone,
    this.token,
    this.hasProfessionalAcc,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      fullname: json["fullname"],
      bio: json["bio"],
      image: json["image"],
      phone: json["phone"],
      token: json["token"],
      hasProfessionalAcc: json["has_professional_acc"],
    );
  }
}
