import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socproject/pages/items_model.dart';


class WishlistScreen extends StatelessWidget {
  final List<Item> wishlist; // List of items in the wishlist

  const WishlistScreen({required this.wishlist, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final item = wishlist[index];
          return ListTile(
            title: Text(item.title ?? ''),
            subtitle: Text(item.category ?? ''),
            trailing: Text('\₹${item.price ?? ''}'),
          );
        },
      ),
    );
  }
}