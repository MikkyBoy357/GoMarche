import 'dart:convert';

import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

/// name : "name"
/// size : "size"
/// price : 300
/// image : ""
/// cartons : 3
/// ordered : ""
/// uid : ""
/// adminId : ""
/// cartId : ""
/// orderedTime : ""
/// location : ""

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  CartItemModel({
    @HiveField(0)
    String? name,
    @HiveField(1)
    String? size,
    @HiveField(2)
    num? price,
    @HiveField(3)
    String? image,
    @HiveField(4)
    num? cartons,
    // String? ordered,
    // String? uid,
    // String? adminId,
    // String? cartId,
    // String? orderedTime,
    // String? location,
  }) {
    _name = name;
    _size = size;
    _price = price;
    _image = image;
    _cartons = cartons;
    // _ordered = ordered;
    // _uid = uid;
    // _adminId = adminId;
    // _cartId = cartId;
    // _orderedTime = orderedTime;
    // _location = location;
  }

  CartItemModel.fromJson(dynamic json) {
    _name = json['name'];
    _size = json['size'];
    _price = json['price'];
    _image = json['image'];
    _cartons = json['cartons'];
    // _ordered = json['ordered'];
    // _uid = json['uid'];
    // _adminId = json['adminId'];
    // _cartId = json['cartId'];
    // _orderedTime = json['orderedTime'];
    // _location = json['location'];
  }

  String? _name;
  String? _size;
  num? _price;
  String? _image;
  num? _cartons;
  // String? _ordered;
  // String? _uid;
  // String? _adminId;
  // String? _cartId;
  // String? _orderedTime;
  // String? _location;

  CartItemModel copyWith({
    String? name,
    String? size,
    num? price,
    String? image,
    num? cartons,
    // String? ordered,
    // String? uid,
    // String? adminId,
    // String? cartId,
    // String? orderedTime,
    // String? location,
  }) =>
      CartItemModel(
        name: name ?? _name,
        size: size ?? _size,
        price: price ?? _price,
        image: image ?? _image,
        cartons: cartons ?? _cartons,
        // ordered: ordered ?? _ordered,
        // uid: uid ?? _uid,
        // adminId: adminId ?? _adminId,
        // cartId: cartId ?? _cartId,
        // orderedTime: orderedTime ?? _orderedTime,
        // location: location ?? _location,
      );

  String? get name => _name;

  String? get size => _size;

  num? get price => _price;

  String? get image => _image;

  num? get cartons => _cartons;

  // String? get ordered => _ordered;
  //
  // String? get uid => _uid;
  //
  // String? get adminId => _adminId;
  //
  // String? get cartId => _cartId;
  //
  // String? get orderedTime => _orderedTime;
  //
  // String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['size'] = _size;
    map['price'] = _price;
    map['image'] = _image;
    map['cartons'] = _cartons;
    // map['ordered'] = _ordered;
    // map['uid'] = _uid;
    // map['adminId'] = _adminId;
    // map['cartId'] = _cartId;
    // map['orderedTime'] = _orderedTime;
    // map['location'] = _location;
    return map;
  }
}
