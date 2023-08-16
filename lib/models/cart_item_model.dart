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

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  num? size;
  @HiveField(2)
  num? price;
  @HiveField(3)
  String? image;
  @HiveField(4)
  num? cartons;

  CartItemModel({
    this.name,
    this.size,
    this.price,
    this.image,
    this.cartons,
  });

  CartItemModel.fromJson(dynamic json) {
    name = json['name'];
    size = json['size'];
    price = json['price'];
    image = json['image'];
    cartons = json['cartons'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['size'] = size;
    map['price'] = price;
    map['image'] = image;
    map['cartons'] = cartons;
    return map;
  }
}
