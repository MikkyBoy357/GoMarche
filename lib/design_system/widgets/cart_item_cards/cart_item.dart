import 'package:flutter/material.dart';
import 'package:go_marche/app_localizations.dart';

class CartItem extends StatelessWidget {
  final String? name;
  final String? size;
  final int? price;
  final String? image;
  final int? cartons;
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
    this.cartons,
    this.ordered,
    this.uid,
    this.adminId,
    this.cartId,
    this.orderedTime,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
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
                  child: Container(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width / 2.3,
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0x90707070),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                  image: NetworkImage(image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: Image(
                              //   image: AssetImage('images/image.png'),
                              // ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  '$cartons ${AppLocalizations.of(context)!.translate('cartons')}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  name != null ? '$size KG ' : 'Size ',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Remove Cart Item");
                                  },
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'CFA ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green[500],
                                  ),
                                ),
                                Text(
                                  price != null ? '$price' : 'Price',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[600],
                                  ),
                                ),
                                Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.cancel_outlined),
        //   ),
        // ),
      ],
    );
  }
}
