import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/screens/home/components/add_to_cart.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;

  const CategoryView({Key? key, required this.categoryName}) : super(key: key);
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        bottom: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            categoryName,
            style: TextStyle(
              color: MyColors.black2,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(categoryName.toLowerCase())
                  .where('categoryId', isEqualTo: categoryName.toLowerCase())
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      // return CartItem();
                      if (index != -1) {
                        return GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            elevation: 4.0,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.130,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x90707070)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.120,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.106,
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //   color: Color(0x90707070),
                                        // ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        image: DecorationImage(
                                          image:
                                          // (snapshot.data!.docs[index]['image'] == '')
                                          //     ? AssetImage('images/image.png'):
                                          NetworkImage(snapshot.data!.docs[index]['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // child: Image(
                                      //   image: AssetImage('images/image.png'),
                                      // ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Container(
                                        // color: Colors.red,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.120,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.020,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                              ['size'] ==
                                                          ''
                                                      ? 'Size'
                                                      : snapshot.data!
                                                          .docs[index]['size'],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'IQD ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                                  ['price'] ==
                                                              ''
                                                          ? 'Price'
                                                          : snapshot.data!
                                                                  .docs[index]
                                                              ['price'],
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
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
                          ),
                          onTap: () {
                             showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return DraggableScrollableSheet(
                                  expand: true,
                                  initialChildSize: 0.95,
                                  maxChildSize: 1,
                                  minChildSize: 0.95,
                                  builder: (BuildContext context,
                                      ScrollController scrollController) {
                                    return AddToCart(
                                      adminId: snapshot.data!.docs[index]
                                          ['adminId'],
                                      name: snapshot.data!.docs[index]['name'],
                                      size: snapshot.data!.docs[index]['size'],
                                      price: snapshot.data!.docs[index]['price'],
                                      image: snapshot.data!.docs[index]['image'],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Category',
                            style: TextStyle(
                              color: MyColors.black2,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
