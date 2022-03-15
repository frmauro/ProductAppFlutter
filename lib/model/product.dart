class Product {
  String id;
  String amount;
  String description;
  String status;
  String price;

  Product({this.id, this.amount, this.description, this.status, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'].toString(),
        amount: json["amount"].toString(),
        description: json["description"],
        status: json["status"],
        price: json["price"].toString());
  }
}
