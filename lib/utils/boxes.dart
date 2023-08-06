import 'package:go_marche/models/cart_item_model.dart';
import 'package:hive/hive.dart';


class Boxes {
  static Box<CartItemModel> getCartItems() => Hive.box<CartItemModel>('cartBox');
}
