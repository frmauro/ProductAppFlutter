import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:product_app/model/product.dart';

//const urlApi = "http://192.168.15.32:8087/product";
//const urlApi = "http://192.168.49.2:31003/product";
//const urlApi = "http://192.168.49.1:31003/product";
//const urlApi = "http://192.168.49.1:6000/product";
// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80";

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage({this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();

  final _descriptionFocus = FocusNode();
  final _amountFocus = FocusNode();
  final _priceFocus = FocusNode();

  bool _productEdited = false;
  Product _editedProduct;

  Future<String> saveProduct(Product product) async {
    final http.Response response = await http.post(
      urlApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'amount': product.amount,
        'description': product.description,
        'price': product.price,
        'status': "Active"
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return "operation success";
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }

  Future<String> updateProduct(Product product) async {
    //int amount = int.parse(product.amount);//STRING to INT

    final http.Response response = await http.put(
      urlApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": product.id,
        'amount': product.amount,
        'description': product.description,
        'price': product.price,
        'status': "Active"
      }),
    );

    //print("**************** STATUS CODE *************************");
    //print(response.statusCode);

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return "operation success";
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.product == null) {
      _editedProduct = new Product();
    } else {
      _editedProduct = widget.product;
      _descriptionController.text = _editedProduct.description;
      _amountController.text = _editedProduct.amount;
      _priceController.text = _editedProduct.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedProduct.description ?? "product description"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("event onPressed");

          //print(_editedProduct.description);
          //print(_editedProduct.id);
          //print(_editedProduct.amount);

          if (_editedProduct.description.isEmpty ||
              _editedProduct.description == null) {
            FocusScope.of(context).requestFocus(_descriptionFocus);
          }

          if (_editedProduct.amount.isEmpty || _editedProduct.amount == null) {
            FocusScope.of(context).requestFocus(_amountFocus);
          }

          if (_editedProduct.price.isEmpty || _editedProduct.price == null) {
            FocusScope.of(context).requestFocus(_priceFocus);
          }

          if (_editedProduct.id == null) {
            print("INSERT");
            saveProduct(_editedProduct).then((result) {
              print("---- Result ----");
              print(result);
              Navigator.pop(context, _editedProduct);
            });
          } else {
            print("UPDATE");
            updateProduct(_editedProduct).then((result) {
              print("---- Result ----");
              print(result);
              Navigator.pop(context, _editedProduct);
            });
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _descriptionController,
              focusNode: _descriptionFocus,
              decoration: InputDecoration(labelText: "Description"),
              onChanged: (text) {
                _productEdited = true;
                setState(() {
                  _editedProduct.description = text;
                });
              },
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: "amount"),
              onChanged: (text) {
                _productEdited = true;
                _editedProduct.amount = text;
              },
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: "price"),
              onChanged: (text) {
                _productEdited = true;
                _editedProduct.price = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
