class Post {
  String? userId;
  late String name;
  late String info;
  late String firstImage;
  String? secondImage;
  String? thirdImage;
  String? fourthImage;

  Post({
    this.userId,
    required this.name,
    required this.info,
    this.thirdImage, required this.firstImage, this.secondImage, this.fourthImage});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    info = json['info'];
    firstImage = json['firstImage'];
    secondImage = json['secondImage'];
    thirdImage = json['thirdImage'];
    fourthImage = json['fourthImage'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'info': info,
    'firstImage': firstImage,
    'secondImage': secondImage,
    'thirdImage': thirdImage,
    'fourthImage': fourthImage,
  };
}