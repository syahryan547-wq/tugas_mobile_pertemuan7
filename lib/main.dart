import 'package:flutter/material.dart';
import 'package:pertemuan7/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tokoparian',
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

//Halaman Produk
class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final Products = [
    Product('Beras Mesir', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlrHF56Ap6i1mTMVOkSeChW3ha8kTUC9VnnjoPsFKvXg&s=10'),
    Product('Minyak Rizki', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSETkU2nvlI-8A0Cg0ZrsqOih_Eex6VtMxrYIZSsx8RhjbTF-am1edx9bc&s=10'),
    Product('Telor Burung Unta', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_IN32jPbbIo6j0XisvCVghtn7NjkCSUANGGjBNib66g&s=10'),
    Product('Air Zam-zam', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU67dl4qc6dUyblB0UZNCcgx7wx1nSbwCb31_1m1cKAA&s'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tokoparian'),
        backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 20),
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Badge(
                  label: Text('${cart.totalItems}'),
                  isLabelVisible: cart.totalItems > 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CartPage()),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Products.length,
        itemBuilder: (contetx, index) {
          final product = Products[index];
          return ListTile(
            leading: Image.network(
              product.gambar,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image, size: 50, color: Colors.grey);
              },
            ),
            title: Text(product.nama),
            shape: BoxBorder.fromLTRB(bottom: BorderSide()),
            trailing: IconButton(
              onPressed: (){
                Provider.of<CartModel>(context, listen: false).add(product);
              },
              icon: Icon(Icons.shopping_cart_checkout)
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Consumer<CartModel>(
        builder:(context, cart, child){
          if(cart.items.isEmpty){
            return Text('Keranjang Kosong');
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder:(context, index) => ListTile(
              leading: Image.network(
                cart.items[index].gambar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 50, color: Colors.grey);
                },
              ),
              title: Text(cart.items[index].nama),
              trailing: IconButton(
                onPressed: (){
                  Provider.of<CartModel>(context, listen: false).remove(cart.items[index]);
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}