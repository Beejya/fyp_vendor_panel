import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../services/baseUrl.dart';

class AddProduct extends StatefulWidget {
  String id;
  AddProduct({super.key, required this.id});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? uploadimage;
  String? category = "";
  int selectedCategory = 1;

  Future<void> chooseImage() async {
    var choosedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  Future<void> uploadData() async {
    var uploadurl = Uri.parse("${baseUrl}images.php");
    try {
      List<int> imageBytes = uploadimage!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(uploadurl, body: {
        'image': baseimage,
        'name': name.text,
        'description': description.text,
        'price': price.text,
        'category': category,
        'quantity': quantity.text,
        'vendor_id': widget.id,
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Product Added Sucessfully',
            style: TextStyle(color: Colors.green),
          )),
        );
        setState(() {
          name.clear();
          description.clear();
          price.clear();
          quantity.clear();
          selectedCategory = 1;
          uploadimage = null;
        });
        var jsondata = json.decode(response.body);
        if (jsondata['error']) {
          print(jsondata['msg']);
        } else {
          print("Error ");
        }
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      super.dispose();
      print("upload sucessful");
    }
  }

  @override
  void initState() {
    name.text;
    price.text;
    description.text;
    category;
    quantity;
  }

  @override
  void dispose() {
    name.clear();
    price.clear();
    description.clear();
    quantity.clear();
  }

  final _formKey = GlobalKey<FormState>();

  var _value = "-1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add product"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                          child: uploadimage == null
                              ? Container()
                              : SizedBox(
                                  height: 150,
                                  child: Image.file(uploadimage!),
                                )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          chooseImage();
                        },
                        icon: Icon(Icons.folder_open),
                        label: Text("Choose Image"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: name,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the name of the product",
                      hintText: "product name",
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    maxLines: 5,
                    controller: description,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the  description for the product",
                      hintText: "Prduct Description ",
                      prefixIcon: Icon(Icons.text_snippet_outlined),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: price,
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the price of the product",
                      hintText: "RS",
                      prefixIcon: Icon(Icons.money),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("-select category-"),
                        value: "-1",
                      ),
                      DropdownMenuItem(
                        child: Text("Men"),
                        value: "1",
                      ),
                      DropdownMenuItem(
                        child: Text("Women"),
                        value: "2",
                      ),
                      DropdownMenuItem(
                        child: Text("Kids"),
                        value: "3",
                      ),
                      DropdownMenuItem(
                        child: Text("All"),
                        value: "4",
                      ),
                    ],
                    onChanged: (value) {
                      if (value == "1") {
                        category = "Men";
                      } else if (value == "2") {
                        category = "Women";
                      } else if (value == "3") {
                        category = "Kid";
                      } else if (value == "4") {
                        category = "All";
                      }
                      print('this is tapped category---$category');
                    },
                  )),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: quantity,
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the quantity of the product",
                      hintText: "Quantity",
                      prefixIcon: Icon(Icons.production_quantity_limits),
                    ),
                  ),
                ),

                //

                Container(
                  child: uploadimage == null
                      ? Container()
                      : ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              uploadData();
                            } else {
                              const SnackBar(
                                  content: Text(
                                'Please enter valid data!',
                                style: TextStyle(color: Colors.green),
                              ));
                            }
                          },
                          icon: Icon(Icons.file_upload),
                          label: Text("Upload Product"),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
