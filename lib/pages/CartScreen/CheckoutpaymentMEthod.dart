import 'package:flutter/material.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/pages/HomePage.dart';
import 'package:flutter_app/toast_component.dart';
import 'package:toast/toast.dart';

class CheckoutPaymentMEthod extends StatefulWidget {
  static const routeName = '/checkoutPaymentmethod';
  @override
  _CheckoutPaymentMEthodState createState() => _CheckoutPaymentMEthodState();
}

class _CheckoutPaymentMEthodState extends State<CheckoutPaymentMEthod> {
  double height = 3;
  FocusNode focusNode;
  String coupon;
  int discountAmount = 50;
  bool visible = false;
  int shipping = 0;
  double total;

  TextEditingController _couponCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomContainer(),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              ToastComponent.showDialog("Order Placed Successfully!", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

              //cod();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFFD2D2C), width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 0.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/cod1.png",
                              fit: BoxFit.fitWidth,
                            ),
                            // FadeInImage.assetNetwork(
                            //   placeholder: 'assets/placeholder.png',
                            //   image: ,
                            //   fit: BoxFit.fitWidth,
                            // )
                          )),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Cash On Delivery",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    height: 1.6,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ToastComponent.showDialog("Order Placed Successfully!", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

              // ssl();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFFD2D2C), width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 0.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/ssl.png",
                              fit: BoxFit.fitWidth,
                            ),
                          )),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Online Payment",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    height: 1.6,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: Container(
              color: Color(0xFFFD2D2C),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  ToastComponent.showDialog(
                      "Order Placed Successfully!", context,
                      gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                },
                child: Text('CHECKOUT'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF3a3737)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Checkout",
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFFFD2D2C),
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
      ),

      height: MediaQuery.of(context).size.width * .5,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              //height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.redAccent,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 230,
                            height: 50,
                            child: TextFormField(
                              onTap: () {
                                focusNode.addListener(
                                  () {
                                    if (focusNode.hasFocus) {
                                      setState(() {
                                        this.height = 1;
                                      });
                                    } else {
                                      setState(() {
                                        this.height = 3;
                                      });
                                    }
                                  },
                                );
                              },
                              controller: _couponCodeController,
                              focusNode: focusNode,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                hintText: "Coupon Code",
                              ),
                            ),
                            padding:
                                EdgeInsets.only(left: 12, right: 12, top: 12),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 10),
                            child: RaisedButton(
                              color: Color(0xFFFD2D2C),
                              textColor: Colors.white,
                              child: Text('Apply'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "SubTotal",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text('240',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Shipping",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text('20',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Total Amount",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text('260',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
