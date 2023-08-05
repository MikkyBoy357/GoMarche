import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCartItem extends StatelessWidget {
  final String name;
  final String size;
  final int price;
  final String image;
  final int cartons;
  final String ordered;
  final String uid;
  final String adminId;
  final String cartId;
  final String orderedTime;
  final String location;

  const AddCartItem({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.image,
    required this.cartons,
    required this.ordered,
    required this.uid,
    required this.adminId,
    required this.cartId,
    required this.orderedTime,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called cartItems that references the firestore collection
    CollectionReference cartItems =
        FirebaseFirestore.instance.collection('carts');

    Future<void> addCartItem() {
      // Call the cartItems CollectionReference to add a new cartItem
      return cartItems
          .add({
            'name': name,
            'size': size,
            'price': price,
            'image': image,
            'cartons': cartons,
            'ordered': ordered,
            'uid': uid,
            'adminId': adminId,
            'cartId': cartId,
            'orderedTime': orderedTime,
            'location': location,
          })
          .then((value) => print("AddCartItem"))
          .catchError((error) => print("Failed to add cartItems: $error"));
    }

    return OutlinedButton(
      onPressed: addCartItem,
      child: Text(
        "AddCartItem",
      ),
    );
  }
}
