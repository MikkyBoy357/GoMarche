import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/widgets/brand_card.dart';
import 'package:go_marche/design_system/widgets/category_card.dart';
import 'package:go_marche/screens/home/components/pageviews/brand_view.dart';

import '../../../app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.translate('home'), style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 30,
              decoration: BoxDecoration(
                color: MyColors.black3,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: MyHomeTabTile(
                      currentItem: "Category",
                      selectedItem: selectedItem,
                      onTap: () {
                        setState(() {
                          selectedItem = 'Category';
                          print(selectedItem);
                        });
                      },
                    ),
                  ),
                  Container(width: 20),
                  Expanded(
                    child: MyHomeTabTile(
                      currentItem: "Brand",
                      selectedItem: selectedItem,
                      onTap: () {
                        setState(() {
                          selectedItem = 'Brand';
                          print(selectedItem);
                        });
                      },
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
                                          categoryName: snapshot.data!
                                              .docs[index]['categoryName'],
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

class MyHomeTabTile extends StatelessWidget {
  final String selectedItem;
  final String currentItem;
  final VoidCallback onTap;

  const MyHomeTabTile({
    super.key,
    required this.selectedItem,
    required this.currentItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedItem == currentItem ? Colors.white : MyColors.black3,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            currentItem,
            style: TextStyle(
              color: Colors.black,
              fontWeight: selectedItem == currentItem
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
