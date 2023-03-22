import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Product_model.dart';
import '../services/baseUrl.dart';

class ProductController {
  Future<List<Product>> getProductsForVendor(String vendorId) async {
    final response =
        await http.get(Uri.parse(baseUrl + "vendorsproductslist.php"));

    if (response.statusCode == 200) {
      print("Hit successfully");
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
