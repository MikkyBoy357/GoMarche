import 'package:flutter/material.dart';
import 'package:go_marche/design_system/widgets/loading_dialog.dart';
import 'package:go_marche/models/cart_item_model.dart';
import 'package:go_marche/view_models/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../design_system/button_widgets/buttons/blue_buttons/button1.dart';
import '../../design_system/colors/colors.dart';
import '../../design_system/widgets/cart_item_cards/cart_item.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  void initState() {
    super.initState();
    CartProvider cartViewModel =
        Provider.of<CartProvider>(context, listen: false);
    cartViewModel.calculateDeliveryFee();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, CartProvider cartProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)!.translate('confirm_order'),
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
                      "Order Items",
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
                          'Please confirm that the items listed below are correct then click Confirm Order ',
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
                    label: AppLocalizations.of(context)!
                        .translate('confirm_order'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmDialog(
                            title: "Finalize Order",
                            body: "Are you sure you want to place this order?",
                            onYes: () async {
                              Navigator.pop(context);
                              await cartProvider.finalizeOrder(this.context);
                            },
                          );
                        },
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return WaitingForOrders();
                      //     },
                      //   ),
                      // );
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
