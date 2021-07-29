import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/animation/ScaleRoute.dart';
import 'package:flutter_app/pages/CartScreen/CheckoutpaymentMEthod.dart';
import 'package:flutter_app/toast_component.dart';
import 'package:toast/toast.dart';

class Cart extends StatefulWidget {
  static const String routeName = '/CartScreen';

  bool back;

  Cart({this.back});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _mainScrollController = ScrollController();
  var _chosenOwnerId = 0;
  var _shopList = [];
  bool _isInitial = true;
  double _cartTotal;
  int cartQuantity;
  var _cartTotalString = ". . .";
  bool hasBottomBar;
  List cartList;
  int itemCount = 0;

  int subTotal = 0;
  int shipping = 0;
  int discountAmount = 50;
  int total = 0;
  int selectedRadio = 1;
  double height = 3;
  String coupon;
  FocusNode focusNode;
  bool visible = false;
  TextEditingController _textEditingController = TextEditingController();
  String token, userId;

  List data = [
    {
      'name': 'Fried Egg',
      'price': 24,
      'quantity': 3,
      'image': 'assets/demo.jpeg'
    },
    {
      'name': 'Mixed Vegetable',
      'price': 20,
      'quantity': 2,
      'image': 'assets/demo2.jpeg'
    },
  ];

  getSetCartTotal() {
    _cartTotal = 0.00;
    if (data.length > 0) {
      for (int i = 0; i < data.length; i++) {
        setState(() {
          _cartTotal += (data[i]['price'].ceil() * data[i]['quantity']);
        });
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getSetCartTotal();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hasBottomBar = ModalRoute.of(context).settings.arguments;
    //print(widget.has_bottomnav);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            CustomScrollView(
              controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildCartItemCard(),
                    ),
                    Container(
                      height: 140,
                    )
                  ]),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildBottomContainer(),
            )
          ],
        ));
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
      ),

      height: hasBottomBar == null ? 120 : 40,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xFFFD2D2C)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Total Amount",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text('${_cartTotal}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width:
                        (MediaQuery.of(context).size.width - 32), // * (2 / 3),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          bottomLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0),
                          bottomRight: const Radius.circular(8.0),
                        )),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,
                      color: Color(0xFFFD2D2C),
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        bottomLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0),
                        bottomRight: const Radius.circular(8.0),
                      )),
                      child: Center(
                        child: Text(
                          "CHECKOUT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onPressed: () async {
                        ToastComponent.showDialog(
                            "Order Placed Successfully!", context,
                            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildBottomCard() {
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

  AppBar buildAppBar(BuildContext context) {
    print(widget.back);
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black38),
      leading: widget.back != null
          ? Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Color(0xFF3a3737)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : Wrap(),
      title: Text(
        "Shopping Cart",
        style: TextStyle(fontSize: 16, color: Color(0xFFFD2D2C)),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  void _handleSellerRadioValueChange(value) {
    setState(() {
      _chosenOwnerId = value;
    });
  }

  buildCartSellerList() {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 0.0, top: 16.0),
                //   child: Row(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: SizedBox(
                //           height: 36,
                //           width: 36,
                //           child: Transform.scale(
                //             scale: .75,
                //             child: Radio(
                //               value: _shopList[index].owner_id,
                //               groupValue: _chosenOwnerId,
                //               activeColor: MyTheme.accent_color,
                //               onChanged: _handleSellerRadioValueChange,
                //             ),
                //           ),
                //         ),
                //       ),
                //       Text(
                //         _shopList[index].name,
                //         style: TextStyle(color: MyTheme.font_grey),
                //       ),
                //       Spacer(),
                //       Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: Text(
                //           partialTotalString(index),
                //           style: TextStyle(
                //               color: MyTheme.accent_color, fontSize: 14),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                //buildCartSellerItemList(index),
              ],
            ),
          );
        },
      ),
    );
  }

  buildCartItemCard() {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String imageLink = data[index]['image'];
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xFFFD2D2C), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0.0,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                Widget>[
              Container(
                  width: 100,
                  height: 100,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image(image: AssetImage(data[index]['image'])))),
              Container(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['name'],
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                height: 1.6,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${data[index]['price'] * data[index]['quantity']}',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Color(0xFFFD2D2C),
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 28,
                                child: InkWell(
                                  onTap: () {
                                    deleteFromCart(context, index);
                                  },
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.add,
                          color: Color(0xFFFD2D2C),
                          size: 18,
                        ),
                        shape: CircleBorder(
                          side: new BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            data[index]['quantity']++;
                            getSetCartTotal();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        '${data[index]['quantity']}',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.remove,
                          color: Color(0xFFFD2D2C),
                          size: 18,
                        ),
                        height: 30,
                        shape: CircleBorder(
                          side: new BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          if (data[index]['quantity'] > 1) {
                            setState(() {
                              data[index]['quantity']--;
                              getSetCartTotal();
                            });
                          }

                          // onQuantityDecrease(seller_index, item_index);
                        },
                      ),
                    )
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }

  deleteFromCart(BuildContext context, int index) {
    print("pressed");
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            content: Text(
              "Are you sure, you want to delete from cart?",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
