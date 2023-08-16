import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/models/ordered_item_model.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../design_system/colors/colors.dart';
import '../../design_system/text_styles/text_styles.dart';
import '../../design_system/widgets/cart_item_cards/order_card.dart';
import '../../view_models/cart_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    CartProvider cartViewModel =
        Provider.of<CartProvider>(context, listen: false);
    cartViewModel.getOrderHistory();
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
              AppLocalizations.of(context)!.translate('order_history'),
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
                    AppLocalizations.of(context)!.translate('order'),
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
                    if (cartProvider.ordersList.isEmpty) {
                      return Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              'Order history will show here',
                              style: MyTextStyles.subtitleStyle,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: cartProvider.ordersList.length,
                          itemBuilder: (context, index) {
                            OrderedItemModel currentOrderedItem =
                                cartProvider.ordersList[index];
                            return OrderCard(
                              orderedItem: currentOrderedItem,
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
          // bottomNavigationBar: MyProductsUploadWidget(),
        );
      },
    );
  }
}

class MyProductsUploadWidget extends StatelessWidget {
  const MyProductsUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      '50000',
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
                onPressed: () async {
                  List productsToAdd = [
                    "Indomie Chicken Flavor",
                    "Indomie Onion Flavor",
                    "Indomie Vegetable Flavor",
                    "Chikki Chicken Noodles",
                    "Honeywell Noodles",
                    "Mimee Noodles",
                    "Supreme Noodles",
                    "Tummy-Tummy Noodles",
                    "Golden Penny Noodles",
                    "Royal Noodles",
                  ];
                  for (var i in productsToAdd) {
                    // Create New Product
                    await FirebaseFirestore.instance
                        .collection('products')
                        .add({
                      "categories": ["Noodles"],
                      "image":
                          "https://jendolstores.com/wp-content/uploads/2020/08/Afrimillz_Indomie.jpg",
                      "name": i,
                      "price": 5000,
                      "size": 5,
                    });
                  }
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
    );
  }
}
