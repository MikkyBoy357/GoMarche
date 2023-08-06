import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
// import 'package:open_location_code/open_location_code.dart' as olc;

class UpdateLocation extends StatefulWidget {
  @override
  _UpdateLocationState createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  String _location = '37.422062,-122.08406';

  String _plusCode = "";

  String _locationDecoded = '37.422062499999996,-122.08405859375';

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getPlusCode() async {
    Position pos = await _getCurrentPosition();
    // print('<<<<>>>> ${_getPlusCode(pos)}');
    // return olc.encode(pos.latitude, pos.longitude, codeLength: 12);
    return pos.toJson().toString();
  }

  // Position _getPosition(String from) {
  //   olc.CodeArea ca = olc.decode(from);
  //   Position position = Position(
  //     latitude: double.parse(ca.center.latitude.toString()),
  //     longitude: double.parse(ca.center.longitude.toString()),
  //     accuracy: 10,
  //     altitude: 10,
  //     floor: 0,
  //     heading: 10,
  //     isMocked: false,
  //     speed: 10,
  //     speedAccuracy: 10,
  //     timestamp: DateTime.now()
  //   );
  //   return position;
  // }

  // _locateMe() async {
  //   Position pos = await _getCurrentPosition();
  //   print('${pos.latitude},${pos.longitude}');
  //   String plusCode = _getPlusCode(pos);
  //   print(plusCode);
  //   Position posDecoded = _getPosition(plusCode);
  //   print('${posDecoded.latitude},${posDecoded.longitude}');
  //   setState(() {
  //     _location = '${pos.latitude},${pos.longitude}';
  //     _plusCode = plusCode;
  //     _locationDecoded = '${posDecoded.latitude},${posDecoded.longitude}';
  //   });
  // }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(_plusCode);
    _controller.text = _plusCode;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update your location',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Your location makes it easy for us to deliver you items.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    enabled: false,
                    controller: _controller,
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Location',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                'Press the update button to update your store location',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(16)),
            //   ),
            //   elevation: 4.0,
            //   child: Container(
            //     height: MediaQuery.of(context).size.height / 4.9,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       // border: Border.all(
            //       //   color: Color(0x90707070),
            //       // ),
            //       borderRadius: BorderRadius.all(Radius.circular(16)),
            //       image: DecorationImage(
            //           image: AssetImage('images/map.png'), scale: 0.5
            //           // fit: BoxFit.cover,
            //           ),
            //     ),
            //     // child: Image(
            //     //   image: AssetImage('images/image.png'),
            //     // ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Button1(
          label: 'Update',
          onPressed: () async {
            print('<<<<>>>> ${await _getPlusCode()}');
            await _getPlusCode();
            Position pos = await _getCurrentPosition();
            print('<<<<>>>> ${await _getPlusCode()}');
            _plusCode = await _getPlusCode();

            // var mich = await _locateMe();
            Navigator.pop(context, _plusCode);
            setState(() {
              DocumentReference documentReference = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid);
              print('=========> RANDOM LOG HAHAHAHAHA');
              Map<String, String> categories = {
                "location": _plusCode,
              };
              print("=======> Firestore Mapping");
              print(categories.toString());
              documentReference.update(categories).whenComplete(
                () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('SUCCESS'),
                        content: Text('Location Added Successfully'),
                      );
                    },
                  ).then((value) => Navigator.pop(context));
                },
              );
            });
          },
        ),
      ),
    );
  }
}
