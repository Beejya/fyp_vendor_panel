import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/views/productdetail.dart';
import 'package:vendor/views/update_detail.dart';
import '../models/Product_model.dart';
import '../services/baseUrl.dart';

class UpdateProduct extends StatefulWidget {
  String id;
  UpdateProduct({super.key, required this.id});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  List<Product> products = [];

  Future<String> getProductData(id) async {
    var response = await http
        .get(Uri.parse("${baseUrl}vendorsproductslist.php?vendor_id=$id"));
    setState(() {
      products = productFromJson(response.body);
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getProductData(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Product"),
        ),
        body: FutureBuilder(
            future: getProductData(widget.id),
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
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateDetails(
                                              product: products[index],
                                            )),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                          ),
                        );
                      }))
                  : Center(
                      child: Container(
                        child: Text(
                          "No Product to Show",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
            }));
  }
}
