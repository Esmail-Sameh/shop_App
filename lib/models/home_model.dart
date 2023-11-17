

class HomeModel {
  bool status;
  String? message;
  Data data;

  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      HomeModel(
        status: json['status'],
        message: json['message'],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  List<Banners> banners = [];
  List<Products> products = [];


  Data({
    required this.banners,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        banners: List<Banners>.from(json['banners'].map(
                (elemant) => Banners.fromJson(elemant))),
        products: List<Products>.from(json["products"].map(
                (elemant) => Products.fromJson(elemant))),
      );
}

class Banners {
  int id;
  String image;

  Banners({
    required this.id,
    required this.image,
  });

  factory Banners.fromJson(Map<String, dynamic> json) =>
      Banners(
        id: json["id"],
        image: json["image"],
      );
}

class Products {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  bool inFavorites;
  bool inCart;

  Products({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.inCart,
  });

  factory Products.fromJson(Map<String, dynamic> json) =>
      Products(
          id: json["id"],
          price: json["price"],
          oldPrice: json["old_price"],
          discount: json["discount"],
          image: json["image"],
          name: json["name"],
          description: json["description"],
          inFavorites: json["in_favorites"],
          inCart: json["in_cart"],
      );
}
