import 'package:flutter/material.dart';
import 'package:go_marche/models/ordered_item_model.dart';

class OrderCard extends StatelessWidget {
  final OrderedItemModel orderedItem;

  const OrderCard({
    Key? key,
    required this.orderedItem,
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
            child: Column(
              children: [],
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
