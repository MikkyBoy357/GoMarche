import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/widgets/cart_item_cards/cart_item.dart';

import '../../../app_localizations.dart';
import 'cart/cartList.dart';

class AddToCart extends StatefulWidget {
  final String adminId;
  final String name;
  final String size;
  final String price;
  final String image;

  const AddToCart({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.image,
    required this.adminId,
  }) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int units = 1;
  int price = 0;

  @override
  void initState() {
    super.initState();
    price = int.parse(widget.price) * units;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var realCartId = "${Const.uid}" + "${DateTime.now().second}";

    print('AdminId: ${widget.adminId}');
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                image: DecorationImage(
                  image:
                      // widget.image == ''
                      //     ? AssetImage('images/image.png') :
                      NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.size,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'IQD $price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.black2,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('quantity'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.black2,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            '$units',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            units > 1
                                ? AppLocalizations.of(context)!
                                    .translate('units')
                                : 'Unit',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                units > 1 ? units = units - 1 : units = units;
                                print('$units Units');
                                price = int.parse(widget.price) * units;
                              });
                            },
                            child: Icon(
                              CupertinoIcons.minus_circled,
                              size: 40,
                            ),
                          ),
                          Container(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                units <= 99 ? units++ : units = units;
                                print('$units Units');
                                price = int.parse(widget.price) * units;
                                print('Price $price');
                              });
                            },
                            child: Icon(
                              CupertinoIcons.plus_circled,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
            Button1(
              label: 'Add to Cart',
              onPressed: () {
                final cartItem = CartItem(
                  name: widget.name,
                  size: widget.size,
                  price: price,
                  image: widget.image,
                  units: units,
                  ordered: 'false',
                  uid: Const.uid,
                  adminId: widget.adminId,
                  cartId: Const.cartItemId,
                );
                myCart.products.add(cartItem);
                print(myCart.products[0].size);
                print('Cart length: ${myCart.products.length}');
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('SUCCESS'),
                      content: Text('${widget.name} Added Successfully'),
                    );
                  },
                );
                // setState(() {
                //   DocumentReference documentReference = FirebaseFirestore
                //       .instance
                //       .collection("cartItems")
                //       .doc(realCartId);
                //   print('=========> RANDOM LOG HAHAHAHAHA');
                //   print(Const.cartItemId);
                //   Map<String, dynamic> categories = {
                //     "name": widget.name,
                //     "size": widget.size,
                //     "price": price,
                //     "image": widget.image,
                //     "units": units,
                //     "ordered": 'false',
                //     "uid": Const.uid,
                //     "adminId": widget.adminId,
                //     "cartId": Const.cartItemId,
                //   };
                //   print("=======> Firestore Mapping");
                //   print(categories.toString());
                //   documentReference.set(categories).whenComplete(
                //     () {
                //       showDialog(
                //         context: context,
                //         builder: (context) {
                //           return CupertinoAlertDialog(
                //             title: Text('SUCCESS'),
                //             content: Text('${widget.name} Added Successfully'),
                //           );
                //         },
                //       );
                //     },
                //   );
                // });
              },
            ),
            Container(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
