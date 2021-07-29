import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Cart extends StatefulWidget {
  static const String routeName = '/CartScreen';

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

  @override
  void initState() {
    // TODO: implement initState

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

      height: hasBottomBar == null ? 200 : 140,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: Colors.blue),
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
                      child: Text('240',
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
                      color: Colors.blue,
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
                      onPressed: () async {},
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: hasBottomBar != null ? true : false,
      iconTheme: IconThemeData(color: Colors.black38),
      leading: hasBottomBar != null
          ? Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : Wrap(),
      title: Text(
        "Shopping Cart",
        style: TextStyle(fontSize: 16, color: Colors.blue),
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
        itemCount: 4,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String imageLink;
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue, width: 1.0),
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
                      child: imageLink != null
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder.png',
                              image: imageLink,
                              fit: BoxFit.fitWidth,
                            )
                          : Image(image: AssetImage('assets/demo.jpeg')))),
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
                            'name',
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
                                  '24',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.blue,
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
                          color: Colors.blue,
                          size: 18,
                        ),
                        shape: CircleBorder(
                          side: new BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        '3',
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
                          color: Colors.blue,
                          size: 18,
                        ),
                        height: 30,
                        shape: CircleBorder(
                          side: new BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {});

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
