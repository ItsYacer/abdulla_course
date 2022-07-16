class CommentModel {
  late String name;
  late String uId;
  late String postId;
  late String image;
  late String dateTime;
  late String text;

  CommentModel({
    required this.name,
    required this.dateTime,
    required this.uId,
    required this.text,
    required this.postId,
    required this.image,
  });

  CommentModel.formJson(Map<String, dynamic>? json) {
    name = json!['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    postId = json['postId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'uId': uId,
      'postId': postId,
      'image': image,
      'dateTime': dateTime,
    };
  }
}