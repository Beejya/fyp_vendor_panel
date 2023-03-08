import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Product_model.dart';
import '../services/baseUrl.dart';

class DeleteProduct extends StatefulWidget {
  const DeleteProduct({super.key});

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  List<Product> products = [];

  Future<String> getProductData() async {
    var response =
        await http.get(Uri.parse(baseUrl + "vendorsproductslist.php"));
    setState(() {
      products = productFromJson(response.body);
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Delete Product")),
        body: FutureBuilder(
            future: getProductData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: products.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            tileColor: Colors.blue.shade50,
                            leading: Container(
                              child: Image.network(
                                baseUrl + "${products[index].image}",
                                height: 200,
                              ),
                            ),
                            title: Text(
                                "Name: ${products[index].name} \nPrice: ${products[index].price}"),
                            subtitle: Text(
                                "Category: ${products[index].category}\nDescription: ${products[index].description}"),
                            trailing: GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () {
                                setState(() {
                                  var url = Uri.parse(
                                      baseUrl + "deleteVendorsProducts.php");
                                  http.post(url,
                                      body: {'id': products[index].id});
                                });
                              },
                            ),
                          ),
                        );
                      }))
                  : Center(
                      child: Container(
                        child: Text(
                          "No Product to delete",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
            }));
  }
}
