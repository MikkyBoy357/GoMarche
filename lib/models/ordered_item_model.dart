import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/models/location_model.dart';

class OrderedItemModel {
  String? uid;
  String? cartId;
  num? timestamp;
  String? status;
  List<CartItemModel>? cartItems;
  LocationModel? location;

  OrderedItemModel({
    this.uid,
    this.cartId,
    this.timestamp,
    this.status,
    this.cartItems,
    this.location,
  });

  OrderedItemModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    cartId = json['cartId'];
    timestamp = json['timestamp'];
    status = json['status'];
    if (json['cartItems'] != null) {
      cartItems = <CartItemModel>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(CartItemModel.fromJson(v));
      });
    }
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['cartId'] = this.cartId;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}
