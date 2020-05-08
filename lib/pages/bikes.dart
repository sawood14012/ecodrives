import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecodrive/pages/book.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rides.dart';
import 'verify_profile.dart';
import 'loyality_page.dart';
import 'complaint_box.dart';
import 'repair_page.dart';

final userRef = Firestore.instance.collection('users');

class BikesPage extends StatefulWidget {
  @override
  _BikesPageState createState() => new _BikesPageState();
}

class _BikesPageState extends State<BikesPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  String location;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getUsers();
    });
    super.initState();
  }

  getUsers() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    DocumentSnapshot doc = await userRef.document(uid).get();
    name = doc['Name'];
    location = doc['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book your E-Drives!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(name == null ? "" : name),
              accountEmail: new Text(location == null ? "" : location),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/quiz-42e65.appspot.com/o/WhatsApp%20Image%202020-01-29%20at%2022.45.53.jpeg?alt=media&token=64b5d018-18c6-4adf-b3fb-c8768097c80e'),
              ),
            ),
//            ListTile(
//              title: new Text('Your Rides'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                    builder: (BuildContext context) => new Rides(),
//                  ),
//                );
//              },
//            ),
//            ListTile(
//              title: new Text('Verify your Profile'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (BuildContext context) =>
//                            new VerifyProfile()));
//              },
//            ),
//            ListTile(
//              title: new Text('Loyalty Programme'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (BuildContext context) => new LoyalityPage()));
//              },
//            ),
//            ListTile(
//              title: new Text('Complaint Box'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (BuildContext context) =>
//                            new ComplaintPage()));
//              },
//            ),
//            ListTile(
//              title: new Text('Repair'),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (BuildContext context) => new RepairPage()));
//              },
//            ),
//            ListTile(
//              title: new Text(
//                'Need Help',
//                style: TextStyle(color: Colors.pink.withOpacity(1.0)),
//              ),
//              onTap: () => AlertDialog(
//                title: Text("For help"),
//                content: Text("tel://+918867208322"),
//              ),
//            ),
            new Container(
              height: 1,
              width: 1,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            ),
            ListTile(
              title: new Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/loginpage');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ecobikeImgae(),
                Text('E Drives', style: TextStyle(fontSize: 24.0)),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/appkm.jpg',
                          height: 40.0,
                        ),
                        Text(
                          '120 Km',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/battery-charging-line-icon-web-and-mobile.jpg',
                          height: 40.0,
                          width: 50.0,
                        ),
                        Text('2hrs(60%)'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_right),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Rent the E- bicycle for delivery and save upto 50% on your vehicle expenditure',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_right),
                    Text('Monthly, Weekly, Daily plan for your need'),
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
              ],
            ),

            // Image.asset(

            //   fit: BoxFit.contain,
            // ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(20),
          ),
        ],
      ),
      floatingActionButton: Transform.scale(
        scale: 1.5,
        child: FloatingActionButton(
          onPressed: () async {
            const url =
                'https://docs.google.com/forms/d/e/1FAIpQLSdtrx-wZTD7vnWGFm8vNQhgd9cWb4vQo7kAxRVzcGdYEXDQWQ/viewform?usp=sf_link';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Text(
            "RENT",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget ecobikeImgae() {
    return Image(image: AssetImage('assets/ecobike.png'), fit: BoxFit.contain);
  }
}
