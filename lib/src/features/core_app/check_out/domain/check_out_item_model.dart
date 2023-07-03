class CartItemModel {
  String itemId;
  String itemName;
  int quantityInCart;
  double price;
  double totalItemPrice; // total item price after deductions - tax & discount
  double
      subTotal; // total price before deductions - tax & discount = price * qauntityInCart
  double discount;
  double tax;

  CartItemModel({
    required this.itemId,
    required this.itemName,
    required this.quantityInCart,
    required this.price,
    required this.totalItemPrice,
    required this.subTotal,
    required this.discount,
    required this.tax,
  });

  // populated from map, that is serializing the stock object from server
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      quantityInCart: map['quantityInCart'] ?? 0,
      price: map['price'] ?? 0.0,
      totalItemPrice: map['totalItemPrice'] ?? 0.0,
      subTotal: map['subTotal'] ?? 0.0,
      discount: map['discount'] ?? 0.0,
      tax: map['tax'] ?? 0.0,
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "itemName": itemName,
      "itemId": itemId,
      "quantityInCart": quantityInCart,
      "price": price,
      "totalItemPrice": totalItemPrice,
      "subTotal": subTotal,
      "discount": discount,
      "tax": tax,
    };
  }
}
