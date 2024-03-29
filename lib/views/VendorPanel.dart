import 'package:flutter/material.dart';
import 'package:vendor/views/delete_product.dart';
import 'package:vendor/views/notification.dart';
import 'package:vendor/views/order_confirm.dart';
import 'package:vendor/views/update_product.dart';
import 'package:vendor/views/view_product.dart';

import 'Signup.dart';
import 'addproduct.dart';
import 'editprofile.dart';
import 'order_detail.dart';

class vendorPanel extends StatefulWidget {
  String? id;
  String name;
  String email;
  vendorPanel({super.key, this.id, required this.name, required this.email});

  @override
  State<vendorPanel> createState() => _vendorPanelState();
}

class _vendorPanelState extends State<vendorPanel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(198, 238, 255, 20),
      appBar: AppBar(
        title: Center(child: Text("Vendor Panel")),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notification_page()),
              );
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(child: Text("Profile")),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: CircleAvatar(
                          child: Text(widget.name),
                          backgroundColor: Colors.amber,
                          radius: 40,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(widget.email)
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            id: widget.id,
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.login),
                title: Text("Log Out"),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProduct(
                                id: widget.id.toString(),
                              )),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 90,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add Product",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewProduct(
                                id: widget.id.toString(),
                              )),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 90,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "View Product",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeleteProduct(
                                id: widget.id.toString(),
                              )),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 90,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Delete Product",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProduct(
                                id: widget.id.toString(),
                              )),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 90,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.system_update,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Update Product",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetail(
                                id: widget.id.toString(),
                              )),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 90,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Order Details",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        // Text(widget.id.toString())
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderConfirm(
                                id: widget.id.toString(),
                              )),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 90,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Order Confirmed",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        // Text(widget.id.toString())
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
