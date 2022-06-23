import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/product_screen.dart';
import 'package:store/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<ProductModel>> _loadPosts() async {
    Response response =
        await Dio().get(
          'https://fakestoreapi.com/products'
        );

    return List<ProductModel>.from(
      response.data.map((d) => ProductModel.fromJson(d)).toList(),
    );
  }
  int _currentIndex = 0;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _loadPosts(),
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final List<ProductModel> products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(
              child: Text("No products found"),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final ProductModel product = products[index];
              return GestureDetector( // permet de détecter une action sur l'écran
                onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                child: Card(
                  
                  child: Column(// permet d'empiler les éléments contrairement à ListTile
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      
                      Image.network(product.image),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top:10.0),
                        child: Column(
                          children: [
                            Text(product.title,
                              style: TextStyle(
                              fontSize: 16,
                              )
                            ),
                          ],
                        ),
                      ),
                      Text(product.price.toString()+"\$",
                        style: TextStyle(
                        fontSize: 16,
                        )
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: false,
        selectedItemColor: Colors.red,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ""
          ),
        ]
      ),
    );
  }
}