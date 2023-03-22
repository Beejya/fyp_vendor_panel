import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Product_model.dart';

import '../services/baseUrl.dart';

class UpdateDetails extends StatefulWidget {
  Product product;
  UpdateDetails({super.key, required this.product});

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  List<Product> products = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<void> makePostRequest() async {
    var url = Uri.parse(baseUrl + 'UpdateAdminProduct.php');
    var response = await http.post(url, body: {
      'id': widget.product.id,
      'name': nameController.text,
      'description': descriptionController.text,
      'price': priceController.text
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Image(
                        image:
                            NetworkImage(baseUrl + "${widget.product.image}")),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isFocused ? Colors.blue : Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter a product name',
                    // hintText: 'Name',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isFocused ? Colors.blue : Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Enter a product price',
                    hintText: 'Rs',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isFocused ? Colors.blue : Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Enter a product description',
                    hintText: 'Description',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  maxLines: 5,
                ),
              ),
            ),
            Container(
              height: 45,
              width: 360,
              child: ElevatedButton(
                onPressed: () {
                  makePostRequest();
                  priceController.clear();
                  descriptionController.clear();
                  nameController.clear();
                  final snackBar = SnackBar(
                    content: Text('Product Updated sucessfully'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('Update Product'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
