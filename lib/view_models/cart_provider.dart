import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/utils/boxes.dart';
import 'package:go_marche/view_models/profile_provider.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> cartItemList = [];
  num totalPrice = 0;

  /// Hive CRUD
  void loadCartList() {
    print('====> Load CartItems List <====');
    cartItemList = Boxes.getCartItems().values.toList();
    print(cartItemList);
    cartItemList.forEach((element) {
      print(element.toJson());
    });
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

  void addCartItem(BuildContext context, Map<String, dynamic> cartItemJson) {
    final newCartItem = CartItemModel();

    final cartBox = Boxes.getCartItems();
    cartBox.add(newCartItem);

    Navigator.pop(context);
    newCartItem.save();
    print('Added: ${newCartItem.toJson()}');
    print('${newCartItem.name} added Succesfully');
    notifyListeners();

    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('SUCCESS'),
          content: Text('${newCartItem.name} Added Successfully'),
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

  void confirmOrder(BuildContext context) {
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    final String? userLocation = profileProvider.userProfileData.location;
    print("userLocation => ${userLocation}");
    if (userLocation!.isEmpty || userLocation == "Location") {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.red[900]),
            ),
            content: Text(
                '\n\nPlease go to the profile page and update your profile'),
          );
        },
      );
    }
  }
}
