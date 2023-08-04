import 'package:flutter/material.dart';
import 'package:go_marche/app_localizations.dart';

class CartItem extends StatelessWidget {
  final String? name;
  final String? size;
  final int? price;
  final String? image;
  final int? units;
  final String? ordered;
  final String? uid;
  final String? adminId;
  final String? cartId;
  final String? orderedTime;
  final String? location;

  const CartItem({
    Key? key,
    this.name,
    this.size,
    this.price,
    this.image,
    this.units,
    this.ordered,
    this.uid,
    this.adminId,
    this.cartId,
    this.orderedTime,
    this.location,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      elevation: 4.0,
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0x90707070)),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(2.0),
            //   child: Container(
            //     height: 96,
            //     width: 96,
            //     decoration: BoxDecoration(
            //       // border: Border.all(
            //       //   color: Color(0x90707070),
            //       // ),
            //       borderRadius: BorderRadius.all(Radius.circular(16)),
            //       image: DecorationImage(
            //         image: image.isEmpty
            //             ? AssetImage('images/image.png')
            //             : NetworkImage(image),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     // child: Image(
            //     //   image: AssetImage('images/image.png'),
            //     // ),
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name != null
                                ? name.toString()
                                : AppLocalizations.of(context)!
                                    .translate('name'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            '$units ${AppLocalizations.of(context)!.translate('units')}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name != null ? '$size KG' : 'Size',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'IQD ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    price != null ? '$price' : 'Price',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
