class StockModel {
  String itemPic;
  String itemName;
  String itemPrice;
  String itemCategory;
  String itemQuantity;

  StockModel({
    required this.itemPic,
    required this.itemName,
    required this.itemPrice,
    required this.itemCategory,
    required this.itemQuantity,
  });

  // populated from map, that is serializing the stock object from server
  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      itemPic: map['itemPic'] ?? '',
      itemName: map['itemName'] ?? '',
      itemPrice: map['itemPrice'] ?? '',
      itemCategory: map['itemCategory'] ?? '',
      itemQuantity: map['itemQuantity'] ?? '',
    );
  }

  // populated to map, that is serializing the stock object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "itemPic": itemPic,
      'itemName': itemName,
      "itemPrice": itemPrice,
      "itemCategory": itemCategory,
      "itemQuantity": itemQuantity,
    };
  }
}
