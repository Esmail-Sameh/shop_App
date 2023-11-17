class FavorittesModel {
  bool status;
  String message;

  FavorittesModel({
    required this.status,
    required this.message,
  });

  factory FavorittesModel.fromJson(Map<String, dynamic> json) =>
      FavorittesModel(
        status: json["status"],
        message: json["message"]
      );
}