import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/text_styles/text_styles.dart';
import 'package:go_marche/design_system/widgets/cart_item_cards/cart_item.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/view_models/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import 'order_history_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    CartProvider cartViewModel =
        Provider.of<CartProvider>(context, listen: false);
    cartViewModel.loadCartList();
  }

  @override
  Widget build(BuildContext context) {
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
            actions: [
              IconButton(
                tooltip: "Order History",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OrderHistoryScreen();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.history,
                  color: MyColors.blue1,
                ),
              ),
            ],
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
                        AppLocalizations.of(context)!.translate('checkout'),
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
