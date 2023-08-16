import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/models/ordered_item_model.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderedItemModel orderedItem;
  final VoidCallback? onTap;

  const OrderCard({
    Key? key,
    required this.orderedItem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        elevation: 4.0,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0x90707070)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailRow(
                title: "ID:",
                label: orderedItem.cartId.toString(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderDetailRow(
                    title: "STATUS: ",
                    label: orderedItem.status.toString(),
                  ),
                  OrderDetailRow(
                    title: "Items: ",
                    label: orderedItem.cartItems!.length.toString(),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      DateTime date = DateTime.fromMillisecondsSinceEpoch(
                        orderedItem.timestamp!.toInt(),
                      );

                      // 24 Hour format:
                      var d24 = DateFormat('dd/MM/yyyy, HH:mm')
                          .format(date); // 31/12/2000, 22:00

                      return OrderDetailRow(
                        title: "TIME: ",
                        label: d24.toString(),
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      num totalCartons = 0;
                      for (var item in orderedItem.cartItems!) {
                        totalCartons += item.cartons!;
                      }

                      return OrderDetailRow(
                        title: "Cartons: ",
                        label: totalCartons.toString(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Builder(builder: (context) {
                num totalPrice = 0;
                for (var item in orderedItem.cartItems!) {
                  totalPrice += item.price! * item.cartons!;
                }
                return OrderDetailRow(
                  title: "Total Price: ",
                  label: "CFA${totalPrice}",
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailRow extends StatelessWidget {
  final String title;
  final String label;

  const OrderDetailRow({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: MyColors.blue3,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
