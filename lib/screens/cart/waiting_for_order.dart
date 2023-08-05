import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/widgets/cart_item_cards/cart_item.dart';
import 'package:go_marche/screens/home/main_screen.dart';

import '../../app_localizations.dart';

class WaitingForOrders extends StatefulWidget {
  final String? name;
  final String? size;
  final String? price;
  final String? image;
  final String? cartons;

  const WaitingForOrders(
      {Key? key,  this.name,  this.size,  this.price,  this.image,  this.cartons})
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.translate('waiting_for_order'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                AppLocalizations.of(context)!.translate('cart'),
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
                    'Your order is on the way.',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If you need help please call us by clicking ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'here.',
                        style: TextStyle(
                          fontSize: 17,
                          color: MyColors.blue1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('carts')
                  // .orderBy('orderedTime', descending: false)
                  .where('uid', isEqualTo: Const.uid)
                  .where('delivered', isEqualTo: 'false')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                print('======> ${snapshot.data!.docs.length}');
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      print('<><><><><>${Const.myCartLength}');
                      return CartItem(
                        name: snapshot.data!.docs[index]['cartFields'][0]
                            ['name'],
                        // .map((e) => e.values.join())
                        // .join(','),
                        size: snapshot.data!.docs[index]['cartFields'][0]
                            ['size'],
                        price: snapshot.data!.docs[0]['cartFields'][0]['price'],
                        image: snapshot.data!.docs[index]['cartFields'][0]
                            ['image'],
                        cartons: snapshot.data!.docs[index]['cartFields'][0]
                            ['cartons'],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
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
                  Row(
                    children: [
                      Text(
                        'IDQ ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$totalPrice',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Button1(
                label: AppLocalizations.of(context)!.translate('home'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MainScreen();
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
  }
}
