/// code : 200
/// message : "ORDER DETAILS LOADED"
/// data : {"id":135,"total_price":"400.00","items":[{"item_id":961,"product_id":1,"name":"Cheeseburger Wendys Burger","image":"http://sonic-zdi0.onrender.com/storage/products/cheeseburger.jpg","quantity":2,"price":"140.00","spicy":"0.10","toppings":[{"id":1,"name":"Tomato","image":"http://sonic-zdi0.onrender.com/storage/toppings/tomato.png"},{"id":2,"name":"Onions","image":"http://sonic-zdi0.onrender.com/storage/toppings/onions.png"},{"id":3,"name":"Pickles","image":"http://sonic-zdi0.onrender.com/storage/toppings/pickles.png"}],"side_options":[{"id":1,"name":"Fries","image":"http://sonic-zdi0.onrender.com/storage/sides/fries.png"},{"id":2,"name":"Coleslaw","image":"http://sonic-zdi0.onrender.com/storage/sides/coleslaw.png"},{"id":3,"name":"Salad","image":"http://sonic-zdi0.onrender.com/storage/sides/salad.png"}]},{"item_id":962,"product_id":3,"name":"Hamburger Chicken Burger","image":"http://sonic-zdi0.onrender.com/storage/products/chicken.jpg","quantity":1,"price":"120.00","spicy":0,"toppings":[],"side_options":[]}]}

class GetCardResponse {
  GetCardResponse({
      this.code, 
      this.message, 
      this.data,});

  GetCardResponse.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? code;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 135
/// total_price : "400.00"
/// items : [{"item_id":961,"product_id":1,"name":"Cheeseburger Wendys Burger","image":"http://sonic-zdi0.onrender.com/storage/products/cheeseburger.jpg","quantity":2,"price":"140.00","spicy":"0.10","toppings":[{"id":1,"name":"Tomato","image":"http://sonic-zdi0.onrender.com/storage/toppings/tomato.png"},{"id":2,"name":"Onions","image":"http://sonic-zdi0.onrender.com/storage/toppings/onions.png"},{"id":3,"name":"Pickles","image":"http://sonic-zdi0.onrender.com/storage/toppings/pickles.png"}],"side_options":[{"id":1,"name":"Fries","image":"http://sonic-zdi0.onrender.com/storage/sides/fries.png"},{"id":2,"name":"Coleslaw","image":"http://sonic-zdi0.onrender.com/storage/sides/coleslaw.png"},{"id":3,"name":"Salad","image":"http://sonic-zdi0.onrender.com/storage/sides/salad.png"}]},{"item_id":962,"product_id":3,"name":"Hamburger Chicken Burger","image":"http://sonic-zdi0.onrender.com/storage/products/chicken.jpg","quantity":1,"price":"120.00","spicy":0,"toppings":[],"side_options":[]}]

class Data {
  Data({
      this.id, 
      this.totalPrice, 
      this.items,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    totalPrice = json['total_price'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  int? id;
  String? totalPrice;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total_price'] = totalPrice;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item_id : 961
/// product_id : 1
/// name : "Cheeseburger Wendys Burger"
/// image : "http://sonic-zdi0.onrender.com/storage/products/cheeseburger.jpg"
/// quantity : 2
/// price : "140.00"
/// spicy : "0.10"
/// toppings : [{"id":1,"name":"Tomato","image":"http://sonic-zdi0.onrender.com/storage/toppings/tomato.png"},{"id":2,"name":"Onions","image":"http://sonic-zdi0.onrender.com/storage/toppings/onions.png"},{"id":3,"name":"Pickles","image":"http://sonic-zdi0.onrender.com/storage/toppings/pickles.png"}]
/// side_options : [{"id":1,"name":"Fries","image":"http://sonic-zdi0.onrender.com/storage/sides/fries.png"},{"id":2,"name":"Coleslaw","image":"http://sonic-zdi0.onrender.com/storage/sides/coleslaw.png"},{"id":3,"name":"Salad","image":"http://sonic-zdi0.onrender.com/storage/sides/salad.png"}]

class Items {
  Items({
      this.itemId, 
      this.productId, 
      this.name, 
      this.image, 
      this.quantity, 
      this.price, 
      this.spicy, 
      this.toppings, 
      this.sideOptions,});

  Items.fromJson(dynamic json) {
    itemId = json['item_id'];
    productId = json['product_id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    spicy = json['spicy'];
    if (json['toppings'] != null) {
      toppings = [];
      json['toppings'].forEach((v) {
        toppings?.add(Toppings.fromJson(v));
      });
    }
    if (json['side_options'] != null) {
      sideOptions = [];
      json['side_options'].forEach((v) {
        sideOptions?.add(SideOptions.fromJson(v));
      });
    }
  }
  int? itemId;
  int? productId;
  String? name;
  String? image;
  int? quantity;
  String? price;
  String? spicy;
  List<Toppings>? toppings;
  List<SideOptions>? sideOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = itemId;
    map['product_id'] = productId;
    map['name'] = name;
    map['image'] = image;
    map['quantity'] = quantity;
    map['price'] = price;
    map['spicy'] = spicy;
    if (toppings != null) {
      map['toppings'] = toppings?.map((v) => v.toJson()).toList();
    }
    if (sideOptions != null) {
      map['side_options'] = sideOptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "Fries"
/// image : "http://sonic-zdi0.onrender.com/storage/sides/fries.png"

class SideOptions {
  SideOptions({
      this.id, 
      this.name, 
      this.image,});

  SideOptions.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  int? id;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}

/// id : 1
/// name : "Tomato"
/// image : "http://sonic-zdi0.onrender.com/storage/toppings/tomato.png"

class Toppings {
  Toppings({
      this.id, 
      this.name, 
      this.image,});

  Toppings.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  int? id;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}