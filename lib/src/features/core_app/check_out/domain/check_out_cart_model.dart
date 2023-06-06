class CheckOutItemModel {
  String cartId;
  String itemName;
  String quantityInCart;
  // String price;
  String totalItemPrice; // total pruce for the item from checkOutItemModel
  String totalCartPrice;
  String subTotal; //
  String discount;
  String tax;

  CheckOutItemModel({
    required this.cartId,
    // required this.itemPic,
    required this.itemName,
    required this.quantityInCart,
    // required this.price,
    required this.totalItemPrice,
    required this.totalCartPrice,
    required this.subTotal,
    required this.discount,
    required this.tax,
  });

  // populated from map, that is serializing the stock object from server
  factory CheckOutItemModel.fromMap(Map<String, dynamic> map) {
    return CheckOutItemModel(
      cartId: map['cartId'] ?? '',
      // itemPic: File(map['itemPic'] ?? ''),
      itemName: map['itemName'] ?? '',
      quantityInCart: map['quantityInCart'] ?? '',
      // // price: map['price'] ?? '',
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
      // "itemPic": itemPic?.path,
      "itemName": itemName,
      "cartId": cartId,
      "quantityInCart": quantityInCart,
      // // "price": price,
      "totalItemPrice": totalItemPrice,
      "totalCartPrice": totalCartPrice,
      "subTotal": subTotal,
      "discount": discount,
      "tax": tax,
    };
  }
}
