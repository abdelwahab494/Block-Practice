import 'dart:convert';

import 'package:bloc_cubit_practice/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<ProductModel>> getProductsData() async {
    final url = Uri.parse("https://fakestoreapi.com/products");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData
          .map<ProductModel>(
            (json) => ProductModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw Exception("Failed To Get Data");
    }
  }
}
