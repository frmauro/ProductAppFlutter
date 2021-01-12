import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import 'package:product_app/model/product.dart';

const urlApi = "http://localhost:8087/product/";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _productController = TextEditingController();
  List<Product> _products = [];

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return null;
        },
      ),
    );
  }
}
