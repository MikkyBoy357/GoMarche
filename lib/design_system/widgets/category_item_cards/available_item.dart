import 'package:flutter/material.dart';

class AvailableItem extends StatelessWidget {
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
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Color(0x90707070),
                // ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage('images/image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image(
              //   image: AssetImage('images/image.png'),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 2.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Item Title',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
