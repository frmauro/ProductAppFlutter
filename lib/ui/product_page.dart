import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:product_app/model/product.dart';

const urlApi = "http://192.168.15.32:8087/product";



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

          if (_editedProduct.description.isEmpty || _editedProduct.description == null){
            FocusScope.of(context).requestFocus(_descriptionFocus);
          }

          if (_editedProduct.amount.isEmpty || _editedProduct.amount == null){
            FocusScope.of(context).requestFocus(_amountFocus);
          }

          if (_editedProduct.price.isEmpty || _editedProduct.price == null){
            FocusScope.of(context).requestFocus(_priceFocus);
          }

          if (_editedProduct.id == null){
            print("INSERT");
            //saveUser(_editedUser).then((result) {
              //print("---- Result ----");
              //print(result);
              //Navigator.pop(context, _editedUser);
            //});

          } else {

            print("UPDATE");
            //updateUser(_editedUser).then((result) {
              //print("---- Result ----");
              //print(result);
              //Navigator.pop(context, _editedUser);
            //});

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