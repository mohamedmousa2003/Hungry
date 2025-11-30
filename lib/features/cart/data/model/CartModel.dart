/// items : [{"product_id":1,"quantity":2,"spicy":0.1,"toppings":[1,2,3],"side_options":[1,2,3]},{"product_id":3,"quantity":1,"toppings":[],"side_options":[]}]

class CartModel {
  CartModel({this.items,});

  CartModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Items {
  Items({
      this.productId, 
      this.quantity, 
      this.spicy, 
      this.toppings, 
      this.sideOptions,});

  Items.fromJson(dynamic json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    spicy = json['spicy'];
    toppings = json['toppings'] != null ? json['toppings'].cast<int>() : [];
    sideOptions = json['side_options'] != null ? json['side_options'].cast<int>() : [];
  }
  int? productId;
  int? quantity;
  double? spicy;
  List<int>? toppings;
  List<int>? sideOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['quantity'] = quantity;
    map['spicy'] = spicy;
    map['toppings'] = toppings;
    map['side_options'] = sideOptions;
    return map;
  }

}