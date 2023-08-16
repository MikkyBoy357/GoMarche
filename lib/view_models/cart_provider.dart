import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/widgets/loading_dialog.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/models/location_model.dart';
import 'package:go_marche/screens/cart/waiting_for_order.dart';
import 'package:go_marche/utils/boxes.dart';
import 'package:go_marche/utils/my_extensions.dart';
import 'package:go_marche/view_models/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/ordered_item_model.dart';
import '../screens/cart/confirm_order_screen.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> cartItemList = [];
  List<OrderedItemModel> ordersList = [];

  num totalPrice = 0;
  num deliveryFee = 0;
  num numberOfItems = 0;

  num checkoutTotal = 0;

  OrderedItemModel orderedItem = OrderedItemModel();

  void calculateCheckoutTotal() {
    checkoutTotal = totalPrice + deliveryFee;
    print("checkoutTotal -> $checkoutTotal");
  }

  void calculateDeliveryFee() {
    /// numberOfItems is the total number of unique items(cartons) in cart
    /// This is not the same as cartLength
    /// numberOfItems -> each carton counts as one item

    numberOfItems = 0;
    for (var cartItem in orderedItem.cartItems!) {
      numberOfItems += cartItem.cartons!;
    }
    print("numberOfItems => $numberOfItems");

    if (numberOfItems.isBetween(1, 10)) {
      deliveryFee = 500;
    } else if (numberOfItems.isBetween(11, 20)) {
      deliveryFee = 1000;
    }

    calculateCheckoutTotal();
    // notifyListeners();
  }

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

  Future<void> getOrderHistory() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("orders")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    //TODO: Get Orders for currentUser and put in a list
    ordersList.clear();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> tempDocs =
        querySnapshot.docs;

    for (var doc in tempDocs) {
      print(doc.data());
      ordersList.add(OrderedItemModel.fromJson(doc.data()));
    }
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in cartItemList) {
      totalPrice += (item.price ?? 0);
    }
    // notifyListeners();
  }

  void addCartItem(BuildContext context, Map<String, dynamic> cartItemJson) {
    final newCartItem = CartItemModel()
      ..name = cartItemJson['name']
      ..size = cartItemJson['size']
      ..price = cartItemJson['price']
      ..image = cartItemJson['image']
      ..cartons = cartItemJson['cartons'];

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

  void checkoutOrder(BuildContext context) async {
    if (cartItemList.isEmpty) {
    } else {
      final ProfileProvider profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);

      await profileProvider.getUserProfileData();

      final LocationModel? userLocation =
          profileProvider.userProfileData.location;
      print("userLocation => ${userLocation}");
      if (userLocation == null || userLocation.latitude == null) {
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
      } else {
        /// Create new OrderedItem
        Uuid uuid = Uuid();
        print(DateTime.now());
        orderedItem = OrderedItemModel(
          cartId: uuid.v1(),
          uid: FirebaseAuth.instance.currentUser!.uid,
          status: "PENDING",
          timestamp: DateTime.now().millisecondsSinceEpoch,
          location: userLocation,
          cartItems: cartItemList,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ConfirmOrderScreen();
            },
          ),
        );
      }
    }
  }

  Future<void> finalizeOrder(BuildContext context) async {
    print("====>Finalize Order<====");
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    await profileProvider.getUserProfileData();

    final LocationModel? userLocation =
        profileProvider.userProfileData.location;
    print("userLocation => ${userLocation}");

    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );
    for (var element in cartItemList) {
      print(element.toJson());
    }

    /// Upload OrderedItem to collection
    CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    print("UploadingOrder => ${orderedItem.cartId}");

    await ordersCollection
        .doc(orderedItem.cartId)
        .set(orderedItem.toJson())
        .whenComplete(() {
      Navigator.of(context, rootNavigator: true).pop(context);
    });

    print("OrderID => ${orderedItem.cartId}");
    print("====>Finalize Order<====");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: WaitingForOrders(),
          );
        },
      ),
    );
  }
}
