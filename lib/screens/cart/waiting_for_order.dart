import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/widgets/cart_item_cards/cart_item.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/screens/home/main_screen.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../view_models/cart_provider.dart';

class WaitingForOrders extends StatefulWidget {
  final String? name;
  final String? size;
  final String? price;
  final String? image;
  final String? cartons;

  const WaitingForOrders(
      {Key? key, this.name, this.size, this.price, this.image, this.cartons})
      : super(key: key);

  @override
  _WaitingForOrdersState createState() => _WaitingForOrdersState();
}

class _WaitingForOrdersState extends State<WaitingForOrders> {
  int totalPrice = 0;

  cartPrice() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('cartItems')
        .where('uid', isEqualTo: Const.uid)
        .where('delivered', isEqualTo: 'false')
        .get();
    for (QueryDocumentSnapshot doc in snap.docs) {
      totalPrice += int.parse(doc['price']);
    }
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    cartPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, CartProvider cartProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              "Order Finalized",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Your order is now PENDING",
                      style: TextStyle(
                        color: MyColors.black2,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your order will be delivered to your store location ASAP. '
                          'Click Done to return to the home screen.',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartProvider.cartItemList.length,
                    itemBuilder: (context, index) {
                      CartItemModel currentCartItem =
                          cartProvider.cartItemList[index];

                      return CartItemCard(
                        cartItem: currentCartItem,
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 180,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                      Text(
                        'CFA ${cartProvider.totalPrice}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'CFA ${cartProvider.deliveryFee}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MyColors.blue1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Checkout Total",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'CFA ${cartProvider.checkoutTotal}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                  Button1(
                    label: AppLocalizations.of(context)!.translate('home'),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async {
                                return false;
                              },
                              child: MainScreen(),
                            );
                          },
                        ),
                      );
                    },
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
