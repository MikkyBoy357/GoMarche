import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/view_models/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../app_localizations.dart';

class AddToCart extends StatefulWidget {
  final String name;
  final num size;
  final num price;
  final String image;

  const AddToCart({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int cartons = 1;
  int price = 0;

  @override
  void initState() {
    super.initState();
    price = int.parse(widget.price.toString()) * cartons;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var realCartId = "${Const.uid}" + "${DateTime.now().second}";

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
                border: Border.all(color: Colors.grey),
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
              "${widget.size}KG",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'CFA $price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
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
                            '$cartons',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            cartons > 1
                                ? AppLocalizations.of(context)!
                                    .translate('cartons')
                                : 'Carton',
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
                                cartons > 1
                                    ? cartons = cartons - 1
                                    : cartons = cartons;
                                print('$cartons Cartons');
                                price = int.parse(widget.price.toString()) *
                                    cartons;
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
                                cartons <= 99 ? cartons++ : cartons = cartons;
                                print('$cartons Cartons');
                                price = int.parse(widget.price.toString()) *
                                    cartons;
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
                final cartItemJson = {
                  "name": widget.name,
                  "size": widget.size,
                  "price": price,
                  "image": widget.image,
                  "cartons": cartons,
                };

                Provider.of<CartProvider>(context, listen: false)
                    .addCartItem(context, cartItemJson);
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
