import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/utils/boxes.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> cartItemList = [];
  num totalPrice = 0;

  /// Hive CRUD
  void loadCartList() {
    print('====> Load CartItems List <====');
    cartItemList = Boxes.getCartItems().values.toList();
    print(cartItemList);
    // notifyListeners();
  }

  Future<List<CartItemModel>> loadCartList2() async {
    print('====> Load CartItems List <====');
    cartItemList = Boxes.getCartItems().values.toList();
    // notifyListeners();
    return cartItemList;
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in cartItemList) {
      totalPrice += (item.price ?? 0);
    }
    // notifyListeners();
  }

  void addCartItem(BuildContext context, CartItemModel cartItem) {
    final cartBox = Boxes.getCartItems();
    cartBox.add(cartItem);
    Navigator.pop(context);
    cartItem.save();
    print('Added: ${cartItem.toJson()}');
    print('${cartItem.name} added Succesfully');
    notifyListeners();

    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('SUCCESS'),
          content: Text('${cartItem.name} Added Successfully'),
        );
      },
    );
  }

  void deleteCartItem(CartItemModel cartItem) {
    final cartBox = Boxes.getCartItems();

    // foodBox.delete(food.key);
    cartItem.delete();
    loadCartList();
    calculateTotalPrice();
    notifyListeners();
  }
}
