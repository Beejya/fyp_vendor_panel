import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/confirm_order.dart';
import '../services/baseUrl.dart';

class OrderConfirm extends StatefulWidget {
  String? id;
  OrderConfirm({super.key, this.id});

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  List<ConfirmOrder> confirmOrder = [];

  Future<String> getConfirmOrderData(id) async {
    var response = await http
        .get(Uri.parse(baseUrl + "confirm_order_list.php?vendorId=$id"));
    setState(() {
      confirmOrder = confirmOrderFromJson(response.body);
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getConfirmOrderData(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Confirm Order"),
        ),
        body: FutureBuilder(
            future: getConfirmOrderData(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: confirmOrder.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Container(
                              color: Colors.grey[300],
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Order Id:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${confirmOrder[index].orderId}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 60,
                                            ),
                                            Icon(Icons.pending_actions_rounded),
                                            Text("Delivery Status:"),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Delivered",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Row(
                                            children: [
                                              Text(
                                                "User Id:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "${confirmOrder[index].userId}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total Price:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "${confirmOrder[index].totalPrice}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Row(
                                            children: [
                                              Text("Quantity Order:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${confirmOrder[index].quantityOrder}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text("Product ID: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${confirmOrder[index].productId}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text("Delivery City: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${confirmOrder[index].deliveryCity}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text("Delivery address: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${confirmOrder[index].deliveryAddress}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text("Contact Number: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${confirmOrder[index].contactNumber}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text("Payment_status: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${confirmOrder[index].paymentStatus}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
                  : Center(
                      child: Container(
                        child: Text(
                          "No order is placed",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
            }));
  }
}
