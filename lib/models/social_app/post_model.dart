class PostModel {
  late String name;
  late String uId;
  late String postUid;
  late String image;
  late String dateTime;
  late String text;
  late String postImage;

  PostModel({
    required this.name,
    required this.dateTime,
    required this.uId,
    required this.text,
    this.postUid ='',
    required this.image,
    required this.postImage,
  });

  PostModel.formJson(Map<String, dynamic>? json) {
    name = json!['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    postUid = json['postUid'];
    image = json['image'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'text': text,
      'uId': uId,
      'postUid': postUid,
      'image': image,
      'dateTime': dateTime,
    };
  }
}
