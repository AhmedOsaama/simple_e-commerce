class CartItem{
  int? id;
  int? qty;
  double? price;
  String? imageURL;
  String? name;

  CartItem({ this.id,  this.name,  this.price,  this.qty = 1,  this.imageURL});

  CartItem.fromJson(dynamic json){
    id = json['id'];
    qty = json['qty'];
    price = json['price'];
    name = json['name'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map['id'] = id;
    map['qty'] = qty;
    map['price'] = price;
    map['name'] = name;
    map['imageURL'] = imageURL;
    return map;
  }
}