import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/models/product_model.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;

  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  Future<Map<String, dynamic>> _loadImage(int id) async{
    final Response response = await Dio().get("https://fakestoreapi.com/products/$id");
    
    return Map<String, dynamic>.from(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            FutureBuilder<Map<String, dynamic>>(
              future: _loadImage(product.id),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }

                return Image.network(product.image);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0,),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      product.title
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 10.0, top:10.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price : "+product.price.toString()+"\$",
                          style: TextStyle(
                            fontSize: 16,
                          )
                        ),
                        Text(
                          "Category: "+product.category,
                          style: TextStyle(
                          fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "Ratings : "+product.rating["rate"].toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only(bottom: 10.0, top:10.0),
                    child: Text(
                      "Description : "+product.description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45.0,
                    child: ElevatedButton(
                      child: Text('Add to cart'),
                      onPressed: () => Fluttertoast.showToast(
                        msg: 'Added to the cart'
                      )
                    ),
                  )
                ]
              )
            )
          ]
        )
      ),
    );
  }
}