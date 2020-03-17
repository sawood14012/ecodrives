import 'package:ecodrive/pages/rentLater.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Book extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book your Ecodrive",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // RaisedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => BookNow(),
            //       ),
            //     );
            //   },
            //   child: const Text('Book Now', style: TextStyle(fontSize: 20)),
            // ),
            const SizedBox(height: 15),
            RaisedButton(
              color: Colors.green,
              // onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute<Null>(
              //         builder: (BuildContext context) {
              //           return Selectdate();
              //         },
              //         fullscreenDialog: true,
              //       ));
              // },
              onPressed: openCheckout2500,
              child: const Text(
                'PreBook your ride!',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pay Rs 100 only!\nOffer valid for first 30 consumers.",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Note:\n1. Vehicle will be handed over to the consumer by End of Feb, 2020.",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
            ), */
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
              child: Text(
                "1. For the people who   have done prebooking, they will get the vehicle at an exclusive price of Rs 3999 for the first month.",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
            ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        child:
        new FlatButton(
            onPressed: () => launch("tel://+918867208322"),
            child: new Text("Click here for Assistance")
        ),
      ),

          ],
        ),
      ),
    );
  }

  void _showDialog(Bookid) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Booking Confirmed"),
          content: new Text("You have Pre Booked an Eco-Drive your book id is : " +Bookid),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogerr(code) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Booking Failed"),
          content: new Text("Your Booking of an Eco-Drive Failed with message: " +code),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Razorpay _razorpay;

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout2500() async {
    var options = {
      'key': 'rzp_live_imQvLYuRRQ8aSG',
      'amount': 10000.0,
      'name': 'Eco Drives',
      'description': 'Eco Drives Payment',
      'prefill': {'contact': '', 'email': ''},

    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
        _showDialog(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
        _showDialogerr(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }


  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
}
