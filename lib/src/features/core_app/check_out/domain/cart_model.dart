class CartModel {
  String cartId;
  String itemName;
  String quantityInCart;
  String totalItemPrice; // total pruce for the item from checkOutItemModel
  String totalCartPrice;
  String subTotal; //
  String discount;
  String tax;

  CartModel({
    required this.cartId,
    required this.itemName,
    required this.quantityInCart,
    required this.totalItemPrice,
    required this.totalCartPrice,
    required this.subTotal,
    required this.discount,
    required this.tax,
  });

  // populated from map, that is serializing the stock object from server
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'] ?? '',
      itemName: map['itemName'] ?? '',
      quantityInCart: map['quantityInCart'] ?? '',
      totalItemPrice: map['totalItemPrice'] ?? '0',
      totalCartPrice: map['totalCartPrice'] ?? '0',
      subTotal: map['subTotal'] ?? '0',
      discount: map['discount'] ?? '0',
      tax: map['tax'] ?? '0',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "itemName": itemName,
      "cartId": cartId,
      "quantityInCart": quantityInCart,
      "totalItemPrice": totalItemPrice,
      "totalCartPrice": totalCartPrice,
      "subTotal": subTotal,
      "discount": discount,
      "tax": tax,
    };
  }
}
