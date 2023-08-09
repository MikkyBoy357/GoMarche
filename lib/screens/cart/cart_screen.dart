import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/text_styles/text_styles.dart';
import 'package:go_marche/design_system/widgets/cart_item_cards/cart_item.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/screens/cart/waiting_for_order.dart';
import 'package:go_marche/view_models/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../dependency_injection/locator.dart';
import '../../local_storage/local_db.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool mich = false;
  bool profile = false;

  // Order variables
  var name;
  var size;
  var orderedPrice;
  var image;
  var cartons;
  var ordered;
  var uid;
  var adminId;
  var cartOrderId;
  String uidI = "";

  Future<bool> checkProfileExist() async {
    // bool exists = false;
    try {
      await FirebaseFirestore.instance
          .doc("users/${Const.uid}")
          .get()
          .then((doc) {
        if (doc.exists)
          profile = true;
        else
          profile = false;
      });
      // print('=======> profile> $profile');
      return profile;
    } catch (e) {
      return false;
    }
  }

  // confirmOrders(String location) {
  //   Const.myCartLength = cartId;
  //   for (var product in myCart.products) {
  //     name = product.name;
  //     orderedPrice = product.price;
  //     ordered = product.ordered;
  //     size = product.size;
  //     ordered = product.price;
  //     image = product.image;
  //     cartons = product.cartons;
  //     uid = product.uid;
  //     adminId = product.adminId;
  //     cartOrderId = 1;
  //     addCartItem(cartItems, location).then(
  //       (value) => showDialog(
  //         context: context,
  //         builder: (context) {
  //           return CupertinoAlertDialog(
  //             title: Text('Success'),
  //             content: Text('\n\nOrder confirmed successfully'),
  //           );
  //         },
  //       ),
  //     );
  //   }
  //   // myCart.products.clear();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return WaitingForOrders();
  //       },
  //     ),
  //   );
  // }

  orderedField() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('cartItems')
        // .where('ordered', isEqualTo: 'true')
        // .where('cartId', isEqualTo: cartId)
        .get();
    for (QueryDocumentSnapshot doc in snap.docs) {
      setState(() {
        // uidI = doc.data()!['uid'];
        uidI = "doc.data()!['uid']";
      });
      // print(',..,${doc.data()!['uid']}');
    }
    setState(() {});
  }

  int myRandom = Random().nextInt(100000);

  // confirmOrder() async {
  // for (var product in myCart.products) {
  CollectionReference cartItems =
      FirebaseFirestore.instance.collection('carts');

  // Future<void> addCartItem(CollectionReference cartItems, String location) {
  //   // Call the cartItems CollectionReference to add a new cartItem
  //   List prods = [];
  //   for (CartItemCard item in myCart.products) {
  //     prods.add({
  //       'name': item.name,
  //       'size': size,
  //       'price': orderedPrice,
  //       'image': image,
  //       'cartons': cartons,
  //       'ordered': ordered,
  //       'uid': uid,
  //       'adminId': adminId,
  //       'cartId': cartId,
  //     });
  //   }
  //
  //   return cartItems
  //       .doc('$cartId')
  //       .set({
  //         "cartFields": prods,
  //         'orderedTime': DateTime.now().toIso8601String(),
  //         'location': location,
  //         'uid': Const.uid,
  //         'delivered': 'false',
  //       })
  //       .then((value) => print("AddCartItem"))
  //       .catchError((error) => print("Failed to add cartItems: $error"));
  // }

  getUserLocation() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(Const.uid)
        .get();
    // print(snap.data()!['location']);
    // print(snap.data()!['orderId']);
    // userLocation = snap.data()!['location'];
    userLocation = "snap.data()!['location']";
  }

  var newIndex;

  late String userLocation;
  String cartId = "${DateTime.now().toIso8601String()}";

  @override
  void initState() {
    super.initState();
    CartProvider cartViewModel =
        Provider.of<CartProvider>(context, listen: false);
    cartViewModel.loadCartList();
  }

  @override
  Widget build(BuildContext context) {
    checkProfileExist();
    Provider.of<CartProvider>(context, listen: false).calculateTotalPrice();

    return Consumer<CartProvider>(
      builder: (context, CartProvider cartProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)!.translate('cart'),
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!.translate('cart'),
                    style: TextStyle(
                      color: MyColors.black2,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    // cartProvider.loadCartList2();
                    if (cartProvider.cartItemList.isEmpty) {
                      return Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              'Cart Items will show here',
                              style: MyTextStyles.subtitleStyle,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: cartProvider.cartItemList.length,
                          // ignore: missing_return
                          itemBuilder: (context, index) {
                            CartItemModel currentCartItem =
                                cartProvider.cartItemList[index];
                            newIndex = index;
                            // return CartItem();
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (DismissDirection dismissDirection) {
                                print(
                                    "SlideToDismiss => Remove Cart Item => ${currentCartItem.name}");
                                cartProvider.deleteCartItem(currentCartItem);
                              },
                              child: CartItemCard(
                                cartItem: currentCartItem,
                                onDelete: () {
                                  print(
                                      "Remove Cart Item => ${currentCartItem.name}");
                                  cartProvider.deleteCartItem(currentCartItem);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.170,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('total'),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'CFA ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600]),
                          ),
                          Text(
                            '${cartProvider.totalPrice}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 2, // the thickness
                          color: MyColors.blue1, // the color of the border
                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        cartProvider.checkoutOrder(context);
                        // print(snapshot.data['location']);
                        // if (profile == true) {
                        //   // snapshot.data!['location'] == null
                        //   //     ? showDialog(
                        //   //         context: context,
                        //   //         builder: (context) {
                        //   //           return CupertinoAlertDialog(
                        //   //             title: Text('Error'),
                        //   //             content: Text(
                        //   //                 '\n\nPlease go to the profile page and update your profile'),
                        //   //           );
                        //   //         },
                        //   //       )
                        //   //     : confirmOrders(snapshot.data!['location']);
                        // } else {
                        //
                        // }
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('checkout'),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// height: MediaQuery.of(context).size.height * 0.065,
// width: MediaQuery.of(context).size.width / 1.1,
