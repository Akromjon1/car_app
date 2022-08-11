class Post {
  String? userId;
  late String name;
  late String model;
  late String info;
  late String price;
  late String firstImage;
  String? secondImage;
  String? thirdImage;
  String? fourthImage;

  Post({
    this.userId,
    required this.name,
    required this.model,
    required this.info, required this.price,
    this.thirdImage, required this.firstImage, this.secondImage, this.fourthImage});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    model = json['model'];
    info = json['info'];
    price = json['price'];
    firstImage = json['firstImage'];
    secondImage = json['secondImage'];
    thirdImage = json['thirdImage'];
    fourthImage = json['fourthImage'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'model': model,
    'info': info,
    'price': price,
    'firstImage': firstImage,
    'secondImage': secondImage,
    'thirdImage': thirdImage,
    'fourthImage': fourthImage,
  };
}