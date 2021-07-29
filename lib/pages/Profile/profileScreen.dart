import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';
  Profile({Key key, this.show_back_button = false}) : super(key: key);

  bool show_back_button;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String token = 'a';
  String username;
  String useremail;
  String userPhone;
  var profiledata;
  List wishList;
  int wishListCoun = 00;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: buildBody(context),
    );
  }

  buildBody(context) {
    if (token == null) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You need to login first',
                style: TextStyle(fontSize: 16, color: Colors.greenAccent),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.greenAccent,
                padding:
                    EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  'Go to Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    } else {
      return CustomScrollView(
        controller: _mainScrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              buildTopSection(),
              buildCountersRow(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  height: 24,
                ),
              ),
              buildHorizontalMenu(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  height: 24,
                ),
              ),
              buildVerticalMenu()
            ]),
          )
        ],
      );
    }
  }

  buildHorizontalMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.assignment_outlined,
                      color: Colors.green,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.amber,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  buildVerticalMenu() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Gold',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Rewards',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Business Profile',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Scheduled',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Challenges',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Saved Places',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Help Center',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Emergency Contacts',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  void logout() {}

  buildCountersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "00",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "In your cart",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                wishList != null ? "0${wishList.length}" : "00",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "In wishlist",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                profiledata != null ? "0${profiledata['orders'].length}" : "00",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Ordered",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
          ],
        )
      ],
    );
  }

  buildTopSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: Color.fromRGBO(112, 112, 112, .3), width: 2),
              //shape: BoxShape.rectangle,
            ),
            child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/man.png',
                  image: "",
                  fit: BoxFit.fill,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            username != null ? username : "Name",
            style: TextStyle(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              useremail != "" && useremail != null ? useremail : "Email",
              style: TextStyle(
                color: Colors.grey,
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              userPhone != "" && userPhone != null ? userPhone : "Phone",
              style: TextStyle(
                color: Colors.grey,
              ),
            )),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
