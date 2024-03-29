import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Product_model.dart';
import '../models/order_model.dart';
import '../services/baseUrl.dart';

class OrderDetail extends StatefulWidget {
  String id;
  OrderDetail({super.key, required this.id});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool isConfirmed = false;
  List<Order> order_detail = [];

  Future<String> getorderData(id) async {
    var response =
        await http.get(Uri.parse(baseUrl + "orderslist.php?vendor_id=$id"));
    setState(() {
      order_detail = orderFromJson(response.body);
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getorderData(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Detail"),
        ),
        body: FutureBuilder(
            future: getorderData(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: order_detail.length,
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
                                              "${order_detail[index].orderId}",
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
                                              "Pending",
                                              style: TextStyle(
                                                  color: Colors.red,
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
                                                  "${order_detail[index].userid}",
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
                                                  "${order_detail[index].totalPrice}",
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
                                                  "${order_detail[index].quantityOrder}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Icon(
                                                  Icons.shopping_cart_checkout),
                                              Text("Confirm Delivery:"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              ElevatedButton(
                                                child: Text("Confirm"),
                                                onPressed: () {
                                                  Get.dialog(AlertDialog(
                                                    title:
                                                        Text("Order Delivery"),
                                                    content: Text(
                                                        "Do you want to confirm or cancel the order?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          var url = Uri.parse(
                                                              '${baseUrl}confirm_order.php');
                                                          var response = http
                                                              .post(url, body: {
                                                            'order_id':
                                                                order_detail[
                                                                        index]
                                                                    .orderId,
                                                            'total_price':
                                                                order_detail[
                                                                        index]
                                                                    .totalPrice,
                                                            'user_id':
                                                                order_detail[
                                                                        index]
                                                                    .userid,
                                                            'quantity_order':
                                                                order_detail[
                                                                        index]
                                                                    .quantityOrder,
                                                            'product_id':
                                                                order_detail[
                                                                        index]
                                                                    .productId,
                                                            'delivery_city':
                                                                order_detail[
                                                                        index]
                                                                    .deliveryCity,
                                                            'delivery_address':
                                                                order_detail[
                                                                        index]
                                                                    .deliveryAddress,
                                                            'contact_number':
                                                                order_detail[
                                                                        index]
                                                                    .contactNumber,
                                                            'payment_status':
                                                                order_detail[
                                                                        index]
                                                                    .paymentStatus,
                                                            'vendor_id':
                                                                order_detail[
                                                                        index]
                                                                    .vendorId,
                                                          });
                                                          setState(() {
                                                            isConfirmed = true;
                                                          });
                                                          Get.back();
                                                        },
                                                        child: Text("Confirm"),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isConfirmed =
                                                                  false;
                                                            });
                                                            Get.back();
                                                          },
                                                          child: Text("Cancel"))
                                                    ],
                                                  ));
                                                },
                                              )
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
                                                  "${order_detail[index].productId}",
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
                                                    "${order_detail[index].deliveryCity}",
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
                                                    "${order_detail[index].deliveryAddress}",
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
                                                    "${order_detail[index].contactNumber}",
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
                                                    "${order_detail[index].paymentStatus}",
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
