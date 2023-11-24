
class GetFavorites {
  bool status;
  dynamic message;
  Data data;

  GetFavorites({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetFavorites.fromJson(Map<String, dynamic> json) => GetFavorites(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  int currentPage;
  List<Datum> data;

  Data({
    required this.currentPage,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );


}

class Datum {
  int id;
  Product product;

  Datum({
    required this.id,
    required this.product,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    product: Product.fromJson(json["product"]),
  );

}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
    name: json["name"],
    description: json["description"],
  );
}
