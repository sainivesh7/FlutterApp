import 'package:flutter/material.dart';
import 'package:socproject/pages/items_model.dart'; // Import the file containing the Item class

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  const ItemDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item Details'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  item.thumb_url!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Name: ${item.title}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8.0),
              Text(
                'Location: ${item.location}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8.0),
              Text(
                'Price: ₹${item.price}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8.0),
              Text(
                'Agent Contact: 9676797629',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
