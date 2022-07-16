
class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String cover;
  late String bio;

  SocialUserModel({
      required this.name,
      this.email  = '',
      required this.phone,
      this.uId = '',
      required this.bio,
      required this.image,
      required this.cover,
});
  SocialUserModel.formJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
