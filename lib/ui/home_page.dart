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
          return _productCard(context, index);
        },
      ),
    );
  }

  Widget _productCard(BuildContext context, int index){
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
                    Text(_products[index].description ?? "",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(_products[index].price ?? "",
                      style: TextStyle(
                          fontSize: 12.0
                      ),
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
    //final recProduct = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(user: user)));

    //if (recProduct != null){
      //if (product != null){
        //method call to update product
      //} else {
        // insert product
      //}
      //method call load users
      //loadUsers();
    }
  }





}
