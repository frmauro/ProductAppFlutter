import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import 'package:product_app/model/product.dart';
import 'package:product_app/ui/product_page.dart';

//const urlApi = "http://192.168.15.32:8087/product";
//const urlApi = "http://192.168.49.2:31003/product";
//const urlApi = "http://192.168.49.1:31003/product";
// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80/product";
//const urlApi = "http://salesorder.com/product";

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

  Future<String> getAllProducts() async {
    http.Response res = await http.get(urlApi, headers: _setHeaders());
    if (res.statusCode == 200) {
      //print(res.body);
      return res.body;
    }
    return "erro";
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    this.getAllProducts().then((body) {
      var jsonProducts = json.decode(body) as List;
      List<dynamic> list;
      _products.clear();

      jsonProducts.forEach((e) {
        _products.add(Product.fromJson(e));
      });
      //print("TESTE 0001");
      //print(_products);
      setState(() {
        _products = _products;
      });
    });
  }

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
        onPressed: () {
          _showProductPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return _productCard(context, index);
        },
      ),
    );
  }

  Widget _productCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _products[index].description ?? "",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _products[index].price ?? "",
                      style: TextStyle(fontSize: 12.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showProductPage(product: _products[index]);
      },
    );
  }

  void _showProductPage({Product product}) async {
    final recProduct = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductPage(product: product)));

    if (recProduct != null) {
      if (product != null) {
        //method call to update product
      } else {
        // insert product
      }
      //method call load users
      loadProducts();
    }
  }
}
