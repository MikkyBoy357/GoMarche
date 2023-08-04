import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/widgets/brand_card.dart';
import 'package:go_marche/design_system/widgets/category_card.dart';
import 'package:go_marche/design_system/widgets/search_bar.dart';
import 'package:go_marche/screens/home/components/pageviews/brand_view.dart';
import '../../filter_screen.dart';
import '../../search_screen.dart';
import 'pageviews/category_view.dart';

class HomeScreen extends StatefulWidget {
  static var uid = FirebaseAuth.instance.currentUser!.uid;

  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedItem = 'Category';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(
    //     '=======> UID: ${FirebaseFirestore.instance.collection('collectionName').get()}');
    print('=======> UID: ${Const.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: SearchBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Search();
                },
              ),
            );
            print('search');
          },
          hintText: 'Search',
          icon: Icon(
            CupertinoIcons.search,
            color: Colors.grey[600],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GestureDetector(
              child: Text(
                'Filter',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return Filter();
                //     },
                //   ),
                // );
              },
            ),
          ),
          Container(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 30,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = 'Category';
                        print(selectedItem);
                      });
                    },
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: selectedItem == 'Category'
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = 'Brand';
                        print(selectedItem);
                      });
                    },
                    child: Text(
                      'Brand',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: selectedItem == 'Brand'
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 10),
            Container(
              child: selectedItem == 'Category'
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, snapshot) {
                        // print(snapshot.error);
                        // print(snapshot.data);
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        return Expanded(
                          child: GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.85,
                            ),
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                categoryName: snapshot.data!.docs[index]
                                    ['categoryName'],
                                image: snapshot.data!.docs[index]['image'],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CategoryView(
                                          categoryName: snapshot
                                              .data!.docs[index]['categoryName'],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    )
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('brands')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.85,
                            ),
                            itemBuilder: (context, index) {
                              return BrandCard(
                                brandName: snapshot.data!.docs[index]
                                    ['brandName'],
                                image: snapshot.data!.docs[index]['image'],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BrandView(
                                          brandName: snapshot.data!.docs[index]
                                              ['brandName'],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
