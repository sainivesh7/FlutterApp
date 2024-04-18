import 'package:flutter/material.dart';
import 'package:socproject/pages/items_model.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemCard(this.item, {required this.onTap, Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 300.0,
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: NetworkImage(widget.item.thumb_url!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.item.category!,
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                widget.item.title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Text(
                      widget.item.location!,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\₹${widget.item.price} ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.item.isInWishlist = !widget.item.isInWishlist;
                      });
                    },
                    icon: Icon(
                      // Change icon based on whether item is in wishlist
                      widget.item.isInWishlist ? Icons.favorite : Icons.favorite_outline,
                      color: widget.item.isInWishlist ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}